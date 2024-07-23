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
    
    private var viewModel: PresentPokemonsCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeCell()
        setupUI()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        herosAbilityLabel.text = nil
        herosImageView.image = nil
        viewModel = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configureCell(with viewModel: PresentPokemonsCellViewModel) {
        self.viewModel = viewModel
        nameLabel.text = viewModel.name
        herosAbilityLabel.text = viewModel.abilities
        
        viewModel.loadImage { [weak self] image in
            self?.herosImageView.image = image
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
        nameLabel.textColor = UIColor.hexE40000
        nameLabel.setCustomFont(name: AppConstants.Fonts.latoBold, size: 16, textStyle: .title1)
        nameLabel.textAlignment = .left
        
        self.addSubview(nameLabel)
    }
    
    private func setupHerosAbilityLabel() {
        herosAbilityLabel.textColor = UIColor.hex50555C
        herosAbilityLabel.setCustomFont(name: AppConstants.Fonts.latoRegular, size: 11, textStyle: .body)
        herosAbilityLabel.textAlignment = .left
        herosAbilityLabel.numberOfLines = 0
        
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
            .trailing(anchor: self.trailingAnchor, constant: 20),
            .height(constant: 36)
        ])
        
        herosImageView.addConstraints(to_view: self, [
            .top(anchor: nameLabel.topAnchor, constant: 0),
            .trailing(anchor: self.trailingAnchor, constant: 0),
            .width(constant: 90),
            .bottom(anchor: self.bottomAnchor, constant: 0)
        ])
    }
}
