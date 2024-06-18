//
//  MainViewController.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 30.05.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    private var backgroundImageView = UIImageView()
    private var mainTitleLabel = UILabel()
    private var presentPokemonsCollectionView: UICollectionView!
    
    private var apiDataManager = ApiDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchPokemonData()
    }
    
    private func fetchPokemonData() {
        apiDataManager.getPokemonGeneralInfoApiData() { result in
            DispatchQueue.main.async {
                switch result {
 //               case .success(let response):
                case .success(_):
                    self.apiDataManager.fetchDataForPreviewCell { success in
                        if success {
                            self.presentPokemonsCollectionView.reloadData()
                        } else {
                            print("Failed to fetch all pokemon details")
                        }
                    }
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
        }
    }
}
 

// MARK: UICollectionView properties

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiDataManager.getAvailablePokemonsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = presentPokemonsCollectionView.dequeueReusableCell(withReuseIdentifier: "MainVCCellId", for: indexPath) as! PresentPokemonsCollectionViewCell
        
        let pokemonDetail = apiDataManager.previewCellPokemonDetails[indexPath.item]
        cell.updateUI(with: pokemonDetail)
        
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
        mainTitleLabel.addConstraints(to_view: view, [
            .top(anchor: view.topAnchor, constant: 135),
            .leading(anchor: view.leadingAnchor, constant: 24),
            .trailing(anchor: view.trailingAnchor, constant: 16),
            .height(constant: 29)
        ])
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
        presentPokemonsCollectionView.addConstraints(to_view: view, [
            .top(anchor: mainTitleLabel.bottomAnchor, constant: 20),
            .leading(anchor: view.leadingAnchor, constant: 24),
            .trailing(anchor: view.trailingAnchor, constant: 24)
        ])
    }
}
