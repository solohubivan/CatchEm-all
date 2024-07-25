//
//  PokemonSpeciesResponse.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 25.07.2024.
//

import Foundation

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
