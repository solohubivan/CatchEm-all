//
//  PokemonApiResponse.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 16.06.2024.
//

import Foundation

struct PokemonMainInfoResponse: Codable {
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
    
    var nextEvolutions: [String]?
    var evolutionTrigger: String?
    var minLevel: Int?
    var evolutionLocation: String?
    
    var moves: [String]?
}
