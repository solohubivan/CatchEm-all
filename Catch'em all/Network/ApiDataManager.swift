//
//  ApiDataManager.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 15.06.2024.
//

import Foundation

class ApiDataManager {
    
    private var availablePokemons: [Pokemon] = []
    
    var previewCellPokemonDetails: [PreviewCellsViewModel] = []
    
    
    // MARK: - Public Methods
    
    func fetchDataForPreviewCell(completion: @escaping (Bool) -> Void) {
        let group = DispatchGroup()
        previewCellPokemonDetails = []
            
        for pokemon in availablePokemons {
            group.enter()
            getPokemonDetailInfo(for: pokemon) { result in
                switch result {
                case .success(let detail):
                    self.previewCellPokemonDetails.append(detail)
                case .failure(let error):
                    print("Failed to fetch details for \(pokemon.name): \(error)")
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(true)
        }
    }
    
    func getAvailablePokemonsCount() -> Int {
        return availablePokemons.count
    }
    
    func getPokemonGeneralInfoApiData(completion: @escaping (Result<PokemonApiResponse, NetworkError>) -> Void) {
        let request = "https://pokeapi.co/api/v2/pokemon"
        
        guard let url = URL(string: request) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(PokemonApiResponse.self, from: data)
                
                self.availablePokemons = apiResponse.results
                
                completion(.success(apiResponse))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        task.resume()
    }

    
    // MARK: - Private Methods
    
    private func getPokemonDetailInfo(for pokemon: Pokemon, completion: @escaping (Result<PreviewCellsViewModel, NetworkError>) -> Void) {
        let cacheKey = pokemon.name
            
        if let cachedModel = CacheManager.shared.getPreviewCellViewModel(forKey: cacheKey) {
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
                let previewCellViewModel = PreviewCellsViewModel(name: pokemon.name, imageURL: imageURL, abilities: abilities)
                    
                CacheManager.shared.cachePreviewCellViewModel(previewCellViewModel, forKey: cacheKey)
                completion(.success(previewCellViewModel))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        task.resume()
    }
}

