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
    
    func getPokemonsDetailInfo() -> [PokemonMainInfoDataModel] {
        return availablePokemons.map {
//            PreviewCellsViewModel(name: $0.name, imageURL: $0.imageURL ?? "", abilities: $0.abilities ?? [""])
            PokemonMainInfoDataModel(
                name: $0.name,
                imageURL: $0.imageURL ?? "",
                abilities: $0.abilities ?? [""],
                height: $0.height ?? 0,
                weight: $0.weight ?? 0,
                attack: $0.attack ?? 0,
                damage: $0.damage ?? 0,
                description: $0.description ?? ""
            )
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
                    self.availablePokemons[index].height = detail.height
                    self.availablePokemons[index].weight = detail.weight
                    self.availablePokemons[index].attack = detail.attack
                    self.availablePokemons[index].damage = detail.damage
                    self.availablePokemons[index].description = detail.description
                })
        }
        return Publishers.MergeMany(publishers)
            .collect()
            .map { _ in () }
            .eraseToAnyPublisher()
    }
    
//    private func getPokemonDetailInfo(for pokemon: Pokemon) -> AnyPublisher<Pokemon, NetworkError> {
//        let cacheKey = pokemon.name
//        
//        if let cachedModel = cacheManager.getPokemonsDetailInfoData(forKey: cacheKey) {
//            return Just(cachedModel)
//                .setFailureType(to: NetworkError.self)
//                .eraseToAnyPublisher()
//        }
//        
//        guard let url = URL(string: pokemon.url) else {
//            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
//        }
//        
//        return ApiBuilder.fetchData(from: url)
//            .map { (pokemonDetail: PokemonDetailInfoData) -> Pokemon in
//                let abilities = pokemonDetail.abilities.map { $0.ability.name }
//                let imageURL = pokemonDetail.sprites.frontDefault
//
//                let attackStat = pokemonDetail.stats.first { $0.stat.name == "attack" }?.baseStat ?? 0
//                let powerStat = pokemonDetail.stats.first { $0.stat.name == "special-attack" }?.baseStat ?? 0
//                let damageStat = pokemonDetail.stats.first { $0.stat.name == "attack" }?.baseStat ?? 0
// 
//                let detail = Pokemon(
//                    name: pokemon.name,
//                    url: pokemon.url,
//                    imageURL: imageURL,
//                    abilities: abilities,
//                    height: pokemonDetail.height,
//                    weight: pokemonDetail.weight,
//                    attack: attackStat,
//                    power: powerStat,
//                    damage: damageStat
//                )
//                self.cacheManager.cachePokemonsDetailInfoData(detail, forKey: cacheKey)
//                return detail
//            }
//            .eraseToAnyPublisher()
//    }
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
            .flatMap { (pokemonDetail: PokemonDetailInfoData) -> AnyPublisher<Pokemon, NetworkError> in
                let abilities = pokemonDetail.abilities.map { $0.ability.name }
                let imageURL = pokemonDetail.sprites.frontDefault

                let attackStat = pokemonDetail.stats.first { $0.stat.name == "attack" }?.baseStat ?? 0
                let damageStat = pokemonDetail.stats.first { $0.stat.name == "attack" }?.baseStat ?? 0
                
                return self.getPokemonSpeciesInfo(for: pokemon)
                .map { description in
                    let detail = Pokemon(
                        name: pokemon.name,
                        url: pokemon.url,
                        imageURL: imageURL,
                        abilities: abilities,
                        height: pokemonDetail.height,
                        weight: pokemonDetail.weight,
                        attack: attackStat,
                        damage: damageStat,
                        description: description
                    )
                    self.cacheManager.cachePokemonsDetailInfoData(detail, forKey: cacheKey)
                    return detail
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func getPokemonSpeciesInfo(for pokemon: Pokemon) -> AnyPublisher<String, NetworkError> {
        guard let url = URL(string: pokemon.url.replacingOccurrences(of: "/pokemon/", with: "/pokemon-species/")) else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }

        return ApiBuilder.fetchData(from: url)
            .map { (speciesResponse: PokemonSpeciesResponse) -> String in
                if let flavorTextEntry = speciesResponse.flavorTextEntries.first(where: { $0.language.name == "en" }) {
                    return flavorTextEntry.flavorText.replacingOccurrences(of: "\n", with: " ")
                }
                return "Description not available"
            }
            .eraseToAnyPublisher()
    }
}
