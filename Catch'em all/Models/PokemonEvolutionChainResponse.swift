//
//  PokemonEvolutionChainResponse.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 25.07.2024.
//

import Foundation

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
