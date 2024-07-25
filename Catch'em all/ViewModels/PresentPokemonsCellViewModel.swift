//
//  PresentPokemonsCellViewModel.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 21.06.2024.
//

import UIKit
import Combine

class PresentPokemonsCellViewModel {
    private var viewModel: PokemonInfo
    private var cancellables = Set<AnyCancellable>()
    private let cacheManager = CacheManager()
    
    init(viewModel: PokemonInfo) {
        self.viewModel = viewModel
    }
    
    var name: String {
        return viewModel.name.uppercased()
    }
    
    var abilities: String {
        return viewModel.abilities.first ?? ""
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = cacheManager.getImage(forKey: viewModel.imageURL) {
            completion(cachedImage)
        } else if let imageUrl = URL(string: viewModel.imageURL) {
            URLSession.shared.dataTaskPublisher(for: imageUrl)
                .map { UIImage(data: $0.data) }
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .sink { image in
                    if let image = image {
                        self.cacheManager.cacheImage(image, forKey: self.viewModel.imageURL)
                    }
                    completion(image)
                }
                .store(in: &cancellables)
        } else {
            completion(nil)
        }
    }
}
