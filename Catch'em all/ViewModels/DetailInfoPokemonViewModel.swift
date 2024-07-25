//
//  DetailInfoPokemonViewModel.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 22.06.2024.
//
import UIKit

class DetailInfoPokemonViewModel {
    private var pokemon: PokemonInfo
    private let cacheManager = CacheManager()
    var currentMode: InfoMode = .about
    
    init(pokemon: PokemonInfo) {
        self.pokemon = pokemon
    }
    
    var name: String {
        return pokemon.name.capitalized
    }
    
    var imageURL: URL? {
        return URL(string: pokemon.imageURL)
    }
    
    var aboutInfo: PokemonInfo {
        return pokemon
    }
    
    var stats: PokemonInfo {
        return pokemon
    }
    
    var evolution: PokemonInfo {
        return pokemon
    }
    
    var moves: [String] {
        return pokemon.moves
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = cacheManager.getImage(forKey: pokemon.imageURL) {
            completion(cachedImage)
        } else if let url = imageURL {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.cacheManager.cacheImage(image, forKey: self.pokemon.imageURL)
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
