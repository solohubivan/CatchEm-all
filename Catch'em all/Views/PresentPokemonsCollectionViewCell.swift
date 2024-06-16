//
//  PresentPokemonsCollectionViewCell.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 07.06.2024.
//

import UIKit

class PresentPokemonsCollectionViewCell: UICollectionViewCell {
    
    var nameLabel = UILabel()
    var herosAbilityLabel = UILabel()
    var herosImageView = UIImageView()
    
    private var apiDataManager = ApiDataManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.15).cgColor
        self.applyShadow(color: UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25))
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK: - Setup UI

extension PresentPokemonsCollectionViewCell {
    private func setupUI() {
        setupNameLabel()
        setupHerosAbilityLabel()
        setupHerosImageView()
    }
    
    private func setupNameLabel() {
        nameLabel.text = ""
        nameLabel.textColor = UIColor.hexE40000
        nameLabel.font = UIFont(name: "Lato-Bold", size: 16)
        nameLabel.textAlignment = .left
        
        self.addSubview(nameLabel)
        nameLabel.addConstraints(to_view: self, [
            .top(anchor: self.topAnchor, constant: 32),
            .leading(anchor: self.leadingAnchor, constant: 9),
            .trailing(anchor: self.trailingAnchor, constant: 9),
            .height(constant: 17)
        ])
    }
    
    private func setupHerosAbilityLabel() {
        herosAbilityLabel.text = "Super Hearing"
        herosAbilityLabel.textColor = UIColor.hex50555C
        herosAbilityLabel.font = UIFont(name: "Lato-Regular", size: 11)
        herosAbilityLabel.textAlignment = .left
        
        self.addSubview(herosAbilityLabel)
        herosAbilityLabel.addConstraints(to_view: self, [
            .top(anchor: nameLabel.bottomAnchor, constant: 5),
            .leading(anchor: self.leadingAnchor, constant: 9),
            .width(constant: 74),
            .height(constant: 13)
        ])
    }
    
    private func setupHerosImageView() {
        herosImageView.contentMode = .scaleAspectFill
        herosImageView.clipsToBounds = true
        herosImageView.image = UIImage(named: "mainVCBackground")
        
        self.addSubview(herosImageView)
        herosImageView.addConstraints(to_view: self, [
            .top(anchor: self.topAnchor, constant: 16),
            .leading(anchor: herosAbilityLabel.trailingAnchor, constant: 8),
            .trailing(anchor: self.trailingAnchor, constant: 8),
            .bottom(anchor: self.bottomAnchor, constant: 20)
        ])
    }
}
