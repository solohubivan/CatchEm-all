//
//  MainViewController.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 30.05.2024.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    private var backgroundImageView = UIImageView()
    private var mainTitleLabel = UILabel()
    private var presentPokemonsCollectionView: UICollectionView!
    
    private var viewModel = MainViewModel()
    private var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        bindViewModel()
        fetchPokemonData()
    }
    
    // MARK: - Private methods
    
    private func fetchPokemonData() {
        guard !isLoading else { return }
        isLoading = true
        
        viewModel.fetchPokemonData()
    }
    
    private func bindViewModel() {
        viewModel.$pokemons
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
                self?.presentPokemonsCollectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}

// MARK: - UICollectionView properties

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = presentPokemonsCollectionView.dequeueReusableCell(withReuseIdentifier: "MainVCCellId", for: indexPath) as! PresentPokemonsCollectionViewCell
            
        let pokemonDetail = viewModel.pokemons[indexPath.item]
        let cellViewModel = PresentPokemonsCellViewModel(viewModel: pokemonDetail)
        cell.configure(with: cellViewModel)
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailedHerosInfoVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2 - 28
        let height = width / 1.4815
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height - 100 {
            fetchPokemonData()
        }
    }
}

// MARK: - Setup UI

extension MainViewController {
    private func setupUI() {
        view.backgroundColor = .white
        setupBackgroundImageView()
        setupMainTitleLabel()
        setupPresentPokemonsCollectionView()
    }
    
    private func setupBackgroundImageView() {
        backgroundImageView.image = UIImage(named: "mainVCBackground")
        backgroundImageView.contentMode = .scaleAspectFit
        
        view.addSubview(backgroundImageView)
        backgroundImageView.addConstraints(to_view: view)
    }
    
    private func setupMainTitleLabel() {
        mainTitleLabel.text = "Know Them All"
        mainTitleLabel.font = UIFont(name:"Lato-Bold", size: 24)
        mainTitleLabel.textColor = UIColor.hex231F20
        
        view.addSubview(mainTitleLabel)
    }

    private func setupPresentPokemonsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        presentPokemonsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        presentPokemonsCollectionView.delegate = self
        presentPokemonsCollectionView.dataSource = self
        presentPokemonsCollectionView.register(PresentPokemonsCollectionViewCell.self, forCellWithReuseIdentifier: "MainVCCellId")
        presentPokemonsCollectionView.layer.masksToBounds = false
        
        presentPokemonsCollectionView.overrideUserInterfaceStyle = .light
        presentPokemonsCollectionView.backgroundColor = .clear
        
        view.addSubview(presentPokemonsCollectionView)
    }
    
    private func setupConstraints() {
        mainTitleLabel.addConstraints(to_view: view, [
            .top(anchor: view.topAnchor, constant: 135),
            .leading(anchor: view.leadingAnchor, constant: 24),
            .trailing(anchor: view.trailingAnchor, constant: 16),
            .height(constant: 29)
        ])
        
        presentPokemonsCollectionView.addConstraints(to_view: view, [
            .top(anchor: mainTitleLabel.bottomAnchor, constant: 20),
            .leading(anchor: view.leadingAnchor, constant: 24),
            .trailing(anchor: view.trailingAnchor, constant: 24)
        ])
    }
}
