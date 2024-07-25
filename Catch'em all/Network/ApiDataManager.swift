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
    private let cacheManager = CacheManager()
    
    // MARK: - Public Methods
    
    func getPokemonsDetailInfo() -> [PokemonInfo] {
        return availablePokemons.map {
            PokemonInfo(
                name: $0.name,
                imageURL: $0.imageURL ?? "",
                abilities: $0.abilities ?? [""],
                height: $0.height ?? 0,
                weight: $0.weight ?? 0,
                attack: $0.attack ?? 0,
                damage: $0.damage ?? 0,
                description: $0.description ?? "",
                
                hp: $0.hp ?? 0,
                defense: $0.defense ?? 0,
                specialAttack: $0.specialAttack ?? 0,
                specialDefense: $0.specialDefense ?? 0,
                speed: $0.speed ?? 0,
                
                nextEvolutions: $0.nextEvolutions ?? [],
                evolutionTrigger: $0.evolutionTrigger ?? "",
                minLevel: $0.minLevel,
                evolutionLocation: $0.evolutionLocation,
                
                moves: $0.moves ?? []
            )
        }
    }
    
    func getPokemonApiData() -> AnyPublisher<Void, NetworkError> {
        guard let request = nextPageURL, let url = URL(string: request) else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        
        return ApiBuilder.fetchData(from: url)
            .flatMap { [unowned self] (response: PokemonMainInfoResponse) -> AnyPublisher<Void, NetworkError> in
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
                    
                    self.availablePokemons[index].hp = detail.hp
                    self.availablePokemons[index].defense = detail.defense
                    self.availablePokemons[index].specialAttack = detail.specialAttack
                    self.availablePokemons[index].specialDefense = detail.specialDefense
                    self.availablePokemons[index].speed = detail.speed

                    self.availablePokemons[index].nextEvolutions = detail.nextEvolutions
                    self.availablePokemons[index].evolutionTrigger = detail.evolutionTrigger
                    self.availablePokemons[index].minLevel = detail.minLevel
                    self.availablePokemons[index].evolutionLocation = detail.evolutionLocation
                    
                    self.availablePokemons[index].moves = detail.moves
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
            .flatMap { (pokemonDetail: PokemonDetailInfoResponse) -> AnyPublisher<Pokemon, NetworkError> in
                let abilities = pokemonDetail.abilities.map { $0.ability.name }
                let imageURL = pokemonDetail.sprites.frontDefault

                let attackStat = pokemonDetail.stats.first { $0.stat.name == "attack" }?.baseStat ?? 0
                let damageStat = pokemonDetail.stats.first { $0.stat.name == "attack" }?.baseStat ?? 0
                let hp = pokemonDetail.stats.first { $0.stat.name == "hp" }?.baseStat ?? 0
                let defense = pokemonDetail.stats.first { $0.stat.name == "defense" }?.baseStat ?? 0
                let specialAttack = pokemonDetail.stats.first { $0.stat.name == "special-attack" }?.baseStat ?? 0
                let specialDefense = pokemonDetail.stats.first { $0.stat.name == "special-defense" }?.baseStat ?? 0
                let speed = pokemonDetail.stats.first { $0.stat.name == "speed" }?.baseStat ?? 0
                
                let moves = pokemonDetail.moves.map { $0.move.name }
        
                return self.getPokemonSpeciesInfo(for: pokemon)
                    .flatMap { speciesInfo -> AnyPublisher<Pokemon, NetworkError> in
                        let description = speciesInfo.description
                        return self.getPokemonEvolutionInfo(for: speciesInfo.evolutionChainUrl)
                            .map { evolutionInfo in
                                let detail = Pokemon(
                                    name: pokemon.name,
                                    url: pokemon.url,
                                    imageURL: imageURL,
                                    abilities: abilities,
                                    height: pokemonDetail.height,
                                    weight: pokemonDetail.weight,
                                    attack: attackStat,
                                    damage: damageStat,
                                    description: description,
                                    hp: hp,
                                    defense: defense,
                                    specialAttack: specialAttack,
                                    specialDefense: specialDefense,
                                    speed: speed,
                                    nextEvolutions: evolutionInfo.nextEvolutions,
                                    evolutionTrigger: evolutionInfo.evolutionTrigger,
                                    minLevel: evolutionInfo.minLevel,
                                    evolutionLocation: evolutionInfo.evolutionLocation,
                                    moves: moves
                                )
                            self.cacheManager.cachePokemonsDetailInfoData(detail, forKey: cacheKey)
                            return detail
                        }
                        .eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
    }
        
    private func getPokemonSpeciesInfo(for pokemon: Pokemon) -> AnyPublisher<(description: String, evolutionChainUrl: String), NetworkError> {
        guard let url = URL(string: pokemon.url.replacingOccurrences(of: "/pokemon/", with: "/pokemon-species/")) else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        
        return ApiBuilder.fetchData(from: url)
            .map { (speciesResponse: PokemonSpeciesResponse) -> (description: String, evolutionChainUrl: String) in
                let description = speciesResponse.flavorTextEntries.first { $0.language.name == "en" }?.flavorText.replacingOccurrences(of: "\n", with: " ") ?? "Description not available"
                let evolutionChainUrl = speciesResponse.evolutionChain.url
                return (description, evolutionChainUrl)
            }
            .eraseToAnyPublisher()
    }
        
    private func getPokemonEvolutionInfo(for url: String) -> AnyPublisher<EvolutionInfo, NetworkError> {
        guard let evolutionChainUrl = URL(string: url) else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
            
        return ApiBuilder.fetchData(from: evolutionChainUrl)
            .map { (evolutionChainResponse: PokemonEvolutionChainResponse) -> EvolutionInfo in
                let nextEvolutions = self.getNextEvolutions(from: evolutionChainResponse.chain.evolvesTo)
                let evolutionDetails = evolutionChainResponse.chain.evolvesTo.first?.evolutionDetails.first
                let evolutionTrigger = evolutionDetails?.trigger.name ?? AppConstants.EvolutionContainerView.defaultValue
                let minLevel = evolutionDetails?.minLevel
                let evolutionLocation = evolutionDetails?.location?.name ?? AppConstants.EvolutionContainerView.defaultValue
                    
                return EvolutionInfo(
                    nextEvolutions: nextEvolutions,
                    evolutionTrigger: evolutionTrigger,
                    minLevel: minLevel,
                    evolutionLocation: evolutionLocation
                )
            }
            .eraseToAnyPublisher()
    }
    
    private func getNextEvolutions(from steps: [PokemonEvolutionChainResponse.EvolutionStep]) -> [String] {
        var evolutions: [String] = []
        for step in steps {
            evolutions.append(step.species.name)
            evolutions.append(contentsOf: getNextEvolutions(from: step.evolvesTo))
        }
        return evolutions
    }
}
