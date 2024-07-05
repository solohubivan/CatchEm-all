//
//  PokemonApiResponse.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 16.06.2024.
//

import Foundation

struct PokemonApiResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: String
    var imageURL: String?
    var abilities: [String]?
    var height: Int?
    var weight: Int?
    var attack: Int?
    var damage: Int?
    var description: String?
    
    var hp: Int?
    var defense: Int?
    var specialAttack: Int?
    var specialDefense: Int?
    var speed: Int?
    
    var currentEvolution: String?
    var nextEvolutions: [String]?
    var evolutionTrigger: String?
    var minLevel: Int?
    var evolutionLocation: String?
    
    var moves: [String]?
}

struct PokemonDetailInfoData: Codable {
    let abilities: [Ability]
    let sprites: Sprites
    let height: Int
    let weight: Int
    let stats: [Stat]
    let moves: [Move]
    
    struct Ability: Codable {
        let ability: NamedResource
    }
    
    struct NamedResource: Codable {
        let name: String
        let url: String
    }
    
    struct Sprites: Codable {
        let frontDefault: String
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
    
    struct Stat: Codable {
        let baseStat: Int
        let effort: Int
        let stat: NamedResource

        enum CodingKeys: String, CodingKey {
            case baseStat = "base_stat"
            case effort
            case stat
        }
    }
    
    struct Move: Codable {
        let move: NamedResource
    }
}

//struct PokemonSpeciesResponse: Codable {
//    let flavorTextEntries: [FlavorTextEntry]
//    
//    enum CodingKeys: String, CodingKey {
//        case flavorTextEntries = "flavor_text_entries"
//    }
//    
//    struct FlavorTextEntry: Codable {
//        let flavorText: String
//        let language: NamedResource
//        
//        enum CodingKeys: String, CodingKey {
//            case flavorText = "flavor_text"
//            case language
//        }
//    }
//    
//    struct NamedResource: Codable {
//        let name: String
//        let url: String
//    }
//}
struct PokemonSpeciesResponse: Codable {
    let flavorTextEntries: [FlavorTextEntry]
    let evolutionChain: EvolutionChain
    
    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
        case evolutionChain = "evolution_chain"
    }
    
    struct FlavorTextEntry: Codable {
        let flavorText: String
        let language: NamedResource
        
        enum CodingKeys: String, CodingKey {
            case flavorText = "flavor_text"
            case language
        }
    }
    
    struct NamedResource: Codable {
        let name: String
        let url: String
    }

    struct EvolutionChain: Codable {
        let url: String
    }
}

struct PokemonEvolutionChainResponse: Codable {
    let chain: EvolutionChain
    
    struct EvolutionChain: Codable {
        let species: NamedResource
        let evolvesTo: [EvolutionStep]
        
        enum CodingKeys: String, CodingKey {
            case species
            case evolvesTo = "evolves_to"
        }
    }
    
    struct EvolutionStep: Codable {
        let species: NamedResource
        let evolvesTo: [EvolutionStep]
        let evolutionDetails: [EvolutionDetail]
        
        enum CodingKeys: String, CodingKey {
            case species
            case evolvesTo = "evolves_to"
            case evolutionDetails = "evolution_details"
        }
    }
    
    struct EvolutionDetail: Codable {
        let trigger: NamedResource
        let minLevel: Int?
        let location: NamedResource?
        
        enum CodingKeys: String, CodingKey {
            case trigger
            case minLevel = "min_level"
            case location
        }
    }
    
    struct NamedResource: Codable {
        let name: String
        let url: String
    }
}
