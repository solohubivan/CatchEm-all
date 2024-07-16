//
//  EvolutionContainerView.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 04.07.2024.
//

import UIKit

class EvolutionContainerView: UIView {
    
    private var currentEvolutionNameLabel = UILabel()
    private var nextEvolutionsNamesLabel = UILabel()
    private var triggerForNextEvolutionStageLabel = UILabel()
    private var minLevelForNextEvolutionStageLabel = UILabel()
    private var placeForNextEvolutionLabel = UILabel()
    
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
        customizeEvolutionParametersLabels()
        setupConstraints()
    }
    
    private func setupEvolutionParametersLabels() {
        self.addSubview(currentEvolutionNameLabel)
        self.addSubview(nextEvolutionsNamesLabel)
        self.addSubview(triggerForNextEvolutionStageLabel)
        self.addSubview(minLevelForNextEvolutionStageLabel)
        self.addSubview(placeForNextEvolutionLabel)
    }
    
    private func customizeEvolutionParametersLabels() {
        currentEvolutionNameLabel.setCustomFont(name: AppConstants.Fonts.latoRegular, size: 13, textStyle: .body)
        nextEvolutionsNamesLabel.setCustomFont(name: AppConstants.Fonts.latoRegular, size: 13, textStyle: .body)
        triggerForNextEvolutionStageLabel.setCustomFont(name: AppConstants.Fonts.latoRegular, size: 13, textStyle: .body)
        minLevelForNextEvolutionStageLabel.setCustomFont(name: AppConstants.Fonts.latoRegular, size: 13, textStyle: .body)
        placeForNextEvolutionLabel.setCustomFont(name: AppConstants.Fonts.latoRegular, size: 13, textStyle: .body)
    }
    
    // MARK: - Privat Methods
    
    private func createLabelText(title: String, value: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(title):", attributes: [
            .foregroundColor: UIColor.black
        ])
            
        let spacing = "    "
        
        let valueText = NSAttributedString(string: "\(spacing)\(value)", attributes: [
            .foregroundColor: UIColor.gray
        ])
            
        attributedText.append(valueText)
        return attributedText
    }
    
    private func createNextEvolutionsText(for viewModel: PokemonMainInfoDataModel) -> String {
        let nextEvolutions = viewModel.nextEvolutions
        let filteredEvolutions = nextEvolutions.filter { $0.capitalized != viewModel.name.capitalized }
            
        if nextEvolutions.last?.capitalized == viewModel.name.capitalized {
            return AppConstants.EvolutionContainerView.lastEvolutionStageLabelText
        } else {
            return filteredEvolutions.joined(separator: ", ").capitalized
        }
    }
    
    // MARK: - Public methods
    
    func updateEvolutionContainerView(with viewModel: PokemonMainInfoDataModel) {
        currentEvolutionNameLabel.attributedText = createLabelText(title: AppConstants.EvolutionContainerView.currentEvolutionParameter, value: viewModel.name.capitalized)
        nextEvolutionsNamesLabel.attributedText = createLabelText(title: AppConstants.EvolutionContainerView.nextEvolutionParameter, value: createNextEvolutionsText(for: viewModel))
        triggerForNextEvolutionStageLabel.attributedText = createLabelText(title: AppConstants.EvolutionContainerView.triggerNextEvolutionParameter, value: viewModel.evolutionTrigger.capitalized)
        minLevelForNextEvolutionStageLabel.attributedText = createLabelText(title: AppConstants.EvolutionContainerView.minimalLevelForEvolutionParameter, value: String(viewModel.minLevel ?? .zero))
        placeForNextEvolutionLabel.attributedText = createLabelText(title: AppConstants.EvolutionContainerView.placeForNextEvolutionParameter, value: viewModel.evolutionLocation?.capitalized ?? AppConstants.EvolutionContainerView.defaultValue)
    }
}

// MARK: - Setup Constraints

extension EvolutionContainerView {
    private func setupConstraints() {
        currentEvolutionNameLabel.addConstraints(to_view: self, [
            .top(anchor: self.topAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        nextEvolutionsNamesLabel.addConstraints(to_view: self, [
            .top(anchor: currentEvolutionNameLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        triggerForNextEvolutionStageLabel.addConstraints(to_view: self, [
            .top(anchor: nextEvolutionsNamesLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        minLevelForNextEvolutionStageLabel.addConstraints(to_view: self, [
            .top(anchor: triggerForNextEvolutionStageLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        placeForNextEvolutionLabel.addConstraints(to_view: self, [
            .top(anchor: minLevelForNextEvolutionStageLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
    }
}
