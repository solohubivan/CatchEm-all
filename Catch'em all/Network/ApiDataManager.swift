//
//  ApiDataManager.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 15.06.2024.
//

import Foundation

class ApiDataManager {
    
    private var availablePokemons: [Pokemon] = []
    private var nextPageURL: String? = "https://pokeapi.co/api/v2/pokemon"
    
    // MARK: - Public Methods
    
    func fetchDataForPreviewCells(at index: Int) -> PreviewCellsViewModel {
        let pokemon = availablePokemons[index]
        let imageURL = pokemon.imageURL ?? ""
        let abilities = pokemon.abilities ?? [""]
        return PreviewCellsViewModel(name: pokemon.name, imageURL: imageURL, abilities: abilities)
    }
    
    func getAvailablePokemonsCount() -> Int {
        return availablePokemons.count
    }
    
    func getPokemonApiData(completion: @escaping (Result<Void, NetworkError>) -> Void) {
        guard let request = nextPageURL, let url = URL(string: request) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(PokemonApiResponse.self, from: data)
                
                self.availablePokemons.append(contentsOf: apiResponse.results)
                self.nextPageURL = apiResponse.next
                
                let group = DispatchGroup()
                for (index, pokemon) in self.availablePokemons.enumerated() {
                    group.enter()
                    self.getPokemonDetailInfo(for: pokemon) { result in
                        switch result {
                        case .success(let detail):
                            self.availablePokemons[index].imageURL = detail.imageURL
                            self.availablePokemons[index].abilities = detail.abilities
                        case .failure(let error):
                            print("Failed to fetch details for \(pokemon.name): \(error)")
                        }
                        group.leave()
                    }
                }
                group.notify(queue: .main) {
                    completion(.success(()))
                }
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        task.resume()
    }
    
    // MARK: - Private Methods
    
    private func getPokemonDetailInfo(for pokemon: Pokemon, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let cacheKey = pokemon.name
        
        if let cachedModel = CacheManager.shared.getPokemonsDetailInfoData(forKey: cacheKey) {
            completion(.success(cachedModel))
            return
        }
        
        guard let url = URL(string: pokemon.url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            
            do {
                let pokemonDetail = try JSONDecoder().decode(PokemonDetailInfoData.self, from: data)
                let abilities = pokemonDetail.abilities.map { $0.ability.name }
                let imageURL = pokemonDetail.sprites.frontDefault
                let pokemonsDetailInfo = Pokemon(name: pokemon.name, url: pokemon.url, imageURL: imageURL, abilities: abilities)
                
                CacheManager.shared.cachePokemonsDetailInfoData(pokemonsDetailInfo, forKey: cacheKey)
                completion(.success(pokemonsDetailInfo))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        task.resume()
    }
}
