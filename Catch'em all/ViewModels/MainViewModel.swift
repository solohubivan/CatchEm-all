//
//  MainViewModel.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 21.06.2024.
//

import UIKit
import Combine

class MainViewModel: ObservableObject {
    
    @Published var pokemons: [PokemonInfo] = []
    private var apiDataManager = ApiDataManager()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPokemonData() {
        apiDataManager.getPokemonApiData()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }, receiveValue: { [weak self] in
                self?.pokemons = self?.apiDataManager.getPokemonsDetailInfo() ?? []
            })
            .store(in: &cancellables)
    }
}
