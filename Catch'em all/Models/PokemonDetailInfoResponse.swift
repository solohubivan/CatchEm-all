//
//  PokemonDetailInfoResponse.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 25.07.2024.
//

import Foundation

struct PokemonDetailInfoResponse: Codable {
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
