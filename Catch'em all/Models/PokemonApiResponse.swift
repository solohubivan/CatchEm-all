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
}

struct PokemonDetailInfoData: Codable {
    let abilities: [Ability]
    let sprites: Sprites
    
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
}
