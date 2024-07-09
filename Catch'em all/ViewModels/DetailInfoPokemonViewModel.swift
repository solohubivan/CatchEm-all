//
//  DetailInfoPokemonViewModel.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 22.06.2024.
//
import UIKit

class DetailInfoPokemonViewModel {
    private var pokemon: PokemonMainInfoDataModel
    
    init(pokemon: PokemonMainInfoDataModel) {
        self.pokemon = pokemon
    }
    
    var name: String {
        return pokemon.name.capitalized
    }
    
    var imageURL: URL? {
        return URL(string: pokemon.imageURL)
    }
    
    var aboutInfo: PokemonMainInfoDataModel {
        return pokemon
    }
    
    var stats: PokemonMainInfoDataModel {
        return pokemon
    }
    
    var evolution: PokemonMainInfoDataModel {
        return pokemon
    }
    
    var moves: [String] {
        return pokemon.moves
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = CacheManager.shared.getImage(forKey: pokemon.imageURL) {
            completion(cachedImage)
        } else if let url = imageURL {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        CacheManager.shared.cacheImage(image, forKey: self.pokemon.imageURL)
                        completion(image)
                    }
                } else {
                    completion(nil)
                }
            }
        } else {
            completion(nil)
        }
    }
}
