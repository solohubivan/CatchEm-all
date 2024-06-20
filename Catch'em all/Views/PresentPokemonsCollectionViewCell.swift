//
//  PresentPokemonsCollectionViewCell.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 07.06.2024.
//

import UIKit

class PresentPokemonsCollectionViewCell: UICollectionViewCell {
    
    private var nameLabel = UILabel()
    private var herosAbilityLabel = UILabel()
    private var herosImageView = UIImageView()
    
    private var apiDataManager = ApiDataManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeCell()
        setupUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func updateUI(with viewModel: PreviewCellsViewModel) {
        nameLabel.text = viewModel.name.uppercased()
        herosAbilityLabel.text = viewModel.abilities.first
            
        if let cachedImage = CacheManager.shared.getImage(forKey: viewModel.imageURL) {
            self.herosImageView.image = cachedImage
        } else if let imageUrl = URL(string: viewModel.imageURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.herosImageView.image = image
                    }
                    CacheManager.shared.cacheImage(image, forKey: viewModel.imageURL)
                }
            }
        }
    }
}

// MARK: - Setup UI

extension PresentPokemonsCollectionViewCell {
    private func setupUI() {
        setupNameLabel()
        setupHerosAbilityLabel()
        setupHerosImageView()
    }
    
    private func customizeCell() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.cellsBorderColor.cgColor
        self.applyShadow(color: UIColor.cellsShadowColor)
    }
    
    private func setupNameLabel() {
        nameLabel.text = ""
        nameLabel.textColor = UIColor.hexE40000
        nameLabel.font = UIFont(name: "Lato-Bold", size: 16)
        nameLabel.textAlignment = .left
        
        self.addSubview(nameLabel)
    }
    
    private func setupHerosAbilityLabel() {
        herosAbilityLabel.text = ""
        herosAbilityLabel.textColor = UIColor.hex50555C
        herosAbilityLabel.font = UIFont(name: "Lato-Regular", size: 11)
        herosAbilityLabel.textAlignment = .left
        
        self.addSubview(herosAbilityLabel)
    }
    
    private func setupHerosImageView() {
        herosImageView.contentMode = .scaleAspectFit
        herosImageView.clipsToBounds = true
        
        self.addSubview(herosImageView)
    }
}

// MARK: - Setup Constraints

extension PresentPokemonsCollectionViewCell {
    private func setupConstraints() {
        
        nameLabel.addConstraints(to_view: self, [
            .top(anchor: self.topAnchor, constant: 32),
            .leading(anchor: self.leadingAnchor, constant: 9),
            .trailing(anchor: self.trailingAnchor, constant: 9),
            .height(constant: 17)
        ])
        
        herosAbilityLabel.addConstraints(to_view: self, [
            .top(anchor: nameLabel.bottomAnchor, constant: 5),
            .leading(anchor: self.leadingAnchor, constant: 9),
            .trailing(anchor: herosImageView.leadingAnchor, constant: 8),
            .height(constant: 14)
        ])
        
        herosImageView.addConstraints(to_view: self, [
            .top(anchor: nameLabel.topAnchor, constant: 0),
            .trailing(anchor: self.trailingAnchor, constant: 0),
            .width(constant: 90),
            .bottom(anchor: self.bottomAnchor, constant: 0)
        ])
    }
}
