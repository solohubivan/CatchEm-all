//
//  EvolutionContainerView.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 04.07.2024.
//
//

import UIKit

class EvolutionContainerView: UIView {
    
    private var currentEvolutionNameTitleLabel = UILabel()
    private var nextEvolutionsNamesTitleLabel = UILabel()
    private var triggerForNextEvolutionStageTitleLabel = UILabel()
    private var minLevelForNextEvolutionStageTitleLabel = UILabel()
    private var placeForNextEvolutionTitleLabel = UILabel()
    
    private var currentEvolutionNameValueLabel = UILabel()
    private var nextEvolutionsNamesValueLabel = UILabel()
    private var triggerForNextEvolutionStageValueLabel = UILabel()
    private var minLevelForNextEvolutionStageValueLabel = UILabel()
    private var placeForNextEvolutionValueLabel = UILabel()
    
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
        setupEvolutionParametersLabels()
        setupConstraints()
    }
    
    private func setupEvolutionParametersLabels() {
        createParametersLabels(labelName: currentEvolutionNameTitleLabel, text: "\(AppConstants.EvolutionContainerView.currentEvolutionParameter):", textColor: .black)
        createParametersLabels(labelName: nextEvolutionsNamesTitleLabel, text: "\(AppConstants.EvolutionContainerView.nextEvolutionParameter):", textColor: .black)
        createParametersLabels(labelName: triggerForNextEvolutionStageTitleLabel, text: "\(AppConstants.EvolutionContainerView.triggerNextEvolutionParameter):", textColor: .black)
        createParametersLabels(labelName: minLevelForNextEvolutionStageTitleLabel, text: "\(AppConstants.EvolutionContainerView.minimalLevelForEvolutionParameter):", textColor: .black)
        createParametersLabels(labelName: placeForNextEvolutionTitleLabel, text: "\(AppConstants.EvolutionContainerView.placeForNextEvolutionParameter):", textColor: .black)
        
        createParametersLabels(labelName: currentEvolutionNameValueLabel, text: "", textColor: .gray)
        createParametersLabels(labelName: nextEvolutionsNamesValueLabel, text: "", textColor: .gray)
        createParametersLabels(labelName: triggerForNextEvolutionStageValueLabel, text: "", textColor: .gray)
        createParametersLabels(labelName: minLevelForNextEvolutionStageValueLabel, text: "", textColor: .gray)
        createParametersLabels(labelName: placeForNextEvolutionValueLabel, text: "", textColor: .gray)
        
        self.addSubview(currentEvolutionNameTitleLabel)
        self.addSubview(nextEvolutionsNamesTitleLabel)
        self.addSubview(triggerForNextEvolutionStageTitleLabel)
        self.addSubview(minLevelForNextEvolutionStageTitleLabel)
        self.addSubview(placeForNextEvolutionTitleLabel)
        
        self.addSubview(currentEvolutionNameValueLabel)
        self.addSubview(nextEvolutionsNamesValueLabel)
        self.addSubview(triggerForNextEvolutionStageValueLabel)
        self.addSubview(minLevelForNextEvolutionStageValueLabel)
        self.addSubview(placeForNextEvolutionValueLabel)
    }
    
    // MARK: - Privat Methods
    
    private func createParametersLabels(labelName: UILabel, text: String, textColor: UIColor) {
        labelName.text = text
        labelName.textColor = textColor
        labelName.setCustomFont(name: AppConstants.Fonts.latoRegular, size: 13, textStyle: .body)
        labelName.textAlignment = .left
        
        labelName.numberOfLines = 0
        labelName.lineBreakMode = .byWordWrapping
    }
    
    private func createNextEvolutionsText(for viewModel: PokemonInfo) -> String {
        let nextEvolutions = viewModel.nextEvolutions
        let filteredEvolutions = nextEvolutions.filter { $0.capitalized != viewModel.name.capitalized }
        
        if nextEvolutions.last?.capitalized == viewModel.name.capitalized {
            return AppConstants.EvolutionContainerView.lastEvolutionStageLabelText
        } else {
            return filteredEvolutions.joined(separator: ", ").capitalized
        }
    }
    
    // MARK: - Public methods
    
    func updateEvolutionContainerView(with viewModel: PokemonInfo) {
        currentEvolutionNameValueLabel.text = viewModel.name.capitalized
        nextEvolutionsNamesValueLabel.text = createNextEvolutionsText(for: viewModel)
        triggerForNextEvolutionStageValueLabel.text = viewModel.evolutionTrigger.capitalized
        minLevelForNextEvolutionStageValueLabel.text = String(viewModel.minLevel ?? .zero)
        placeForNextEvolutionValueLabel.text = viewModel.evolutionLocation?.capitalized ?? AppConstants.EvolutionContainerView.defaultValue
    }
}

// MARK: - Setup Constraints

extension EvolutionContainerView {
    private func setupConstraints() {
        currentEvolutionNameTitleLabel.addConstraints(to_view: self, [
            .top(anchor: self.topAnchor, constant: 8),
            .height(constant: 45),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .width(constant: 120)
        ])
        currentEvolutionNameValueLabel.addConstraints(to_view: self, [
            .top(anchor: self.topAnchor, constant: 8),
            .height(constant: 45),
            .leading(anchor: currentEvolutionNameTitleLabel.trailingAnchor, constant: 10),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        
        nextEvolutionsNamesTitleLabel.addConstraints(to_view: self, [
            .top(anchor: currentEvolutionNameTitleLabel.bottomAnchor, constant: 8),
            .height(constant: 45),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .width(constant: 120)
        ])
        nextEvolutionsNamesValueLabel.addConstraints(to_view: self, [
            .top(anchor: currentEvolutionNameValueLabel.bottomAnchor, constant: 8),
            .height(constant: 45),
            .leading(anchor: nextEvolutionsNamesTitleLabel.trailingAnchor, constant: 10),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        
        triggerForNextEvolutionStageTitleLabel.addConstraints(to_view: self, [
            .top(anchor: nextEvolutionsNamesValueLabel.bottomAnchor, constant: 8),
            .height(constant: 45),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .width(constant: 120)
        ])
        triggerForNextEvolutionStageValueLabel.addConstraints(to_view: self, [
            .top(anchor: nextEvolutionsNamesValueLabel.bottomAnchor, constant: 8),
            .height(constant: 45),
            .leading(anchor: triggerForNextEvolutionStageTitleLabel.trailingAnchor, constant: 10),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])

        minLevelForNextEvolutionStageTitleLabel.addConstraints(to_view: self, [
            .top(anchor: triggerForNextEvolutionStageTitleLabel.bottomAnchor, constant: 8),
            .height(constant: 45),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .width(constant: 120)
        ])
        minLevelForNextEvolutionStageValueLabel.addConstraints(to_view: self, [
            .top(anchor: triggerForNextEvolutionStageValueLabel.bottomAnchor, constant: 8),
            .height(constant: 45),
            .leading(anchor: minLevelForNextEvolutionStageTitleLabel.trailingAnchor, constant: 10),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        
        placeForNextEvolutionTitleLabel.addConstraints(to_view: self, [
            .top(anchor: minLevelForNextEvolutionStageTitleLabel.bottomAnchor, constant: 8),
            .height(constant: 45),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .width(constant: 120)
        ])
        placeForNextEvolutionValueLabel.addConstraints(to_view: self, [
            .top(anchor: minLevelForNextEvolutionStageValueLabel.bottomAnchor, constant: 8),
            .height(constant: 45),
            .leading(anchor: placeForNextEvolutionTitleLabel.trailingAnchor, constant: 10),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
    }
}
