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
}

struct PokemonDetailInfoData: Codable {
    let abilities: [Ability]
    let sprites: Sprites
    let height: Int
    let weight: Int
    let stats: [Stat]
    
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
}

struct PokemonSpeciesResponse: Codable {
    let flavorTextEntries: [FlavorTextEntry]
    
    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
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
}
