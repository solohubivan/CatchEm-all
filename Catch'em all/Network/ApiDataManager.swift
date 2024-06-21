//
//  ApiDataManager.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 15.06.2024.
//

import Foundation
import Combine

class ApiDataManager {
    
    private var availablePokemons: [Pokemon] = []
    private var nextPageURL: String? = "https://pokeapi.co/api/v2/pokemon"
    private var cancellables = Set<AnyCancellable>()
    private let cacheManager = CacheManager.shared
    
    // MARK: - Public Methods
    
    func getPreviewCellViewModels() -> [PreviewCellsViewModel] {
        return availablePokemons.map {
            PreviewCellsViewModel(name: $0.name, imageURL: $0.imageURL ?? "", abilities: $0.abilities ?? [""])
        }
    }
    
    func getPokemonApiData() -> AnyPublisher<Void, NetworkError> {
        guard let request = nextPageURL, let url = URL(string: request) else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        
        return ApiBuilder.fetchData(from: url)
            .flatMap { [unowned self] (response: PokemonApiResponse) -> AnyPublisher<Void, NetworkError> in
                self.availablePokemons.append(contentsOf: response.results)
                self.nextPageURL = response.next
                return self.fetchDetailsForAllPokemons()
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private Methods
    
    private func fetchDetailsForAllPokemons() -> AnyPublisher<Void, NetworkError> {
        let publishers = availablePokemons.enumerated().map { (index, pokemon) in
            getPokemonDetailInfo(for: pokemon)
                .handleEvents(receiveOutput: { [unowned self] detail in
                    self.availablePokemons[index].imageURL = detail.imageURL
                    self.availablePokemons[index].abilities = detail.abilities
                })
        }
        return Publishers.MergeMany(publishers)
            .collect()
            .map { _ in () }
            .eraseToAnyPublisher()
    }
    
    private func getPokemonDetailInfo(for pokemon: Pokemon) -> AnyPublisher<Pokemon, NetworkError> {
        let cacheKey = pokemon.name
        
        if let cachedModel = cacheManager.getPokemonsDetailInfoData(forKey: cacheKey) {
            return Just(cachedModel)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        
        guard let url = URL(string: pokemon.url) else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        
        return ApiBuilder.fetchData(from: url)
            .map { (pokemonDetail: PokemonDetailInfoData) -> Pokemon in
                let abilities = pokemonDetail.abilities.map { $0.ability.name }
                let imageURL = pokemonDetail.sprites.frontDefault
                let detail = Pokemon(name: pokemon.name, url: pokemon.url, imageURL: imageURL, abilities: abilities)
                self.cacheManager.cachePokemonsDetailInfoData(detail, forKey: cacheKey)
                return detail
            }
            .eraseToAnyPublisher()
    }
}
