//
//  StatsContainerView.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 29.06.2024.
//

import UIKit

class StatsContainerView: UIView {
    
    private var pokemonHPTitleLabel = UILabel()
    private var pokemonAttackTitleLabel = UILabel()
    private var pokemonSpecialAttackTitleLabel = UILabel()
    private var pokemonDefenseTitleLabel = UILabel()
    private var pokemonSpecialDefenseTitleLabel = UILabel()
    private var pokemonSpeedTitleLabel = UILabel()
    
    private var pokemonHPValueLabel = UILabel()
    private var pokemonAttackValueLabel = UILabel()
    private var pokemonSpecialAttackValueLabel = UILabel()
    private var pokemonDefenseValueLabel = UILabel()
    private var pokemonSpecialDefenseValueLabel = UILabel()
    private var pokemonSpeedValueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Setup UI
    
    private func setupUI() {
        self.backgroundColor = .clear
        setupStatsParametersLabels()
        setupConstraints()
    }
    
    private func setupStatsParametersLabels() {
        createParametersLabels(labelName: pokemonHPTitleLabel, text: "HP", textColor: .black)
        createParametersLabels(labelName: pokemonAttackTitleLabel, text: "Attack", textColor: .black)
        createParametersLabels(labelName: pokemonSpecialAttackTitleLabel, text: "SpecAttack", textColor: .black)
        createParametersLabels(labelName: pokemonDefenseTitleLabel, text: "DefenseLabel", textColor: .black)
        createParametersLabels(labelName: pokemonSpecialDefenseTitleLabel, text: "SpecDefense", textColor: .black)
        createParametersLabels(labelName: pokemonSpeedTitleLabel, text: "Speed", textColor: .black)
        
        createParametersLabels(labelName: pokemonHPValueLabel, text: "1", textColor: UIColor.hexDADADA)
        createParametersLabels(labelName: pokemonAttackValueLabel, text: "1", textColor: UIColor.hexDADADA)
        createParametersLabels(labelName: pokemonSpecialAttackValueLabel, text: "1", textColor: UIColor.hexDADADA)
        createParametersLabels(labelName: pokemonDefenseValueLabel, text: "1", textColor: UIColor.hexDADADA)
        createParametersLabels(labelName: pokemonSpecialDefenseValueLabel, text: "1", textColor: UIColor.hexDADADA)
        createParametersLabels(labelName: pokemonSpeedValueLabel, text: "1", textColor: UIColor.hexDADADA)
        
        self.addSubview(pokemonHPTitleLabel)
        self.addSubview(pokemonAttackTitleLabel)
        self.addSubview(pokemonSpecialAttackTitleLabel)
        self.addSubview(pokemonDefenseTitleLabel)
        self.addSubview(pokemonSpecialDefenseTitleLabel)
        self.addSubview(pokemonSpeedTitleLabel)
        
        self.addSubview(pokemonHPValueLabel)
        self.addSubview(pokemonAttackValueLabel)
        self.addSubview(pokemonSpecialAttackValueLabel)
        self.addSubview(pokemonDefenseValueLabel)
        self.addSubview(pokemonSpecialDefenseValueLabel)
        self.addSubview(pokemonSpeedValueLabel)
    }
    
    // MARK: - Privat Methods
    
    private func createParametersLabels(labelName: UILabel, text: String, textColor: UIColor) {
        labelName.text = text
        labelName.textColor = textColor
        labelName.font = UIFont(name: "Lato-Regular", size: 13)
        labelName.textAlignment = .left
    }
}

extension StatsContainerView {
    private func setupConstraints() {
        pokemonHPTitleLabel.addConstraints(to_view: self, [
            .top(anchor: self.topAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: pokemonHPValueLabel.leadingAnchor, constant: 10)
        ])
        pokemonAttackTitleLabel.addConstraints(to_view: self, [
            .top(anchor: pokemonHPTitleLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: pokemonAttackValueLabel.leadingAnchor, constant: 10)
        ])
        pokemonSpecialAttackTitleLabel.addConstraints(to_view: self, [
            .top(anchor: pokemonAttackTitleLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: pokemonSpecialAttackValueLabel.leadingAnchor, constant: 10)
        ])
        pokemonDefenseTitleLabel.addConstraints(to_view: self, [
            .top(anchor: pokemonSpecialAttackTitleLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: pokemonDefenseValueLabel.leadingAnchor, constant: 10)
        ])
        pokemonSpecialDefenseTitleLabel.addConstraints(to_view: self, [
            .top(anchor: pokemonDefenseTitleLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: pokemonSpecialDefenseValueLabel.leadingAnchor, constant: 10)
        ])
        pokemonSpeedTitleLabel.addConstraints(to_view: self, [
            .top(anchor: pokemonSpecialDefenseTitleLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: pokemonSpeedValueLabel.leadingAnchor, constant: 10)
        ])
        
        pokemonHPValueLabel.addConstraints(to_view: self, [
            .top(anchor: self.topAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 180),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        pokemonAttackValueLabel.addConstraints(to_view: self, [
            .top(anchor: pokemonHPValueLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 180),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        pokemonSpecialAttackValueLabel.addConstraints(to_view: self, [
            .top(anchor: pokemonAttackValueLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 180),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        pokemonDefenseValueLabel.addConstraints(to_view: self, [
            .top(anchor: pokemonSpecialAttackValueLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 180),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        pokemonSpecialDefenseValueLabel.addConstraints(to_view: self, [
            .top(anchor: pokemonDefenseValueLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 180),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        pokemonSpeedValueLabel.addConstraints(to_view: self, [
            .top(anchor: pokemonSpecialDefenseValueLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 180),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
    }
}
