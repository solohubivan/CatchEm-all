//
//  PokemonMainInfoDataModel.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 16.06.2024.
//

import Foundation

struct PokemonMainInfoDataModel: Codable {
    var name: String
    var imageURL: String
    var abilities: [String]
    var height: Int
    var weight: Int
    var attack: Int
    var damage: Int
    var description: String
}
