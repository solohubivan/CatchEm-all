//
//  AboutContainerView.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 25.06.2024.
//

import UIKit

class AboutContainerView: UIView {

    private var heightParameterTitleLabel = UILabel()
    private var weightParameterTitleLabel = UILabel()
    private var powerParameterTitleLabel = UILabel()
    private var attackParameterTitleLabel = UILabel()
    private var attackParameterValueLabel = UILabel()
    private var damageParameterTitleLabel = UILabel()
    private var heightParameterValueLabel = UILabel()
    private var weightParameterValueLabel = UILabel()
    private var powerParameterValueLabel = UILabel()
    private var damageParameterValueLabel = UILabel()
    private var generalInfoTextView = UITextView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        self.backgroundColor = .clear
        setupPokemonParametersLabels()
        setupGeneralInfoTextView()
        setupConstraints()
    }

    // MARK: - Privat Methods
    
    private func createParametersLabels(labelName: UILabel, text: String, textColor: UIColor) {
        labelName.text = text
        labelName.textColor = textColor
        labelName.setCustomFont(name: AppConstants.Fonts.latoRegular, size: 13, textStyle: .body)
        
        labelName.textAlignment = .left
    }
    
    private func createAttackParameter(value: Int) {
        let attackValue = max(1, min(value / 10, 10))
            
        let attributedString = NSMutableAttributedString()
            
        for _ in 0..<attackValue {
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: AppConstants.ImageNames.fireSpin)
            attachment.bounds = CGRect(x: 0, y: -5, width: 20, height: 20)
            attributedString.append(NSAttributedString(attachment: attachment))
            attributedString.append(NSAttributedString(string: " "))
        }
        
        attackParameterValueLabel.attributedText = attributedString
    }

    // MARK: - Public Methods
    
    func updateAboutContainerView(with viewModel: PokemonMainInfoDataModel) {
        let heightValue = viewModel.height * 100
        let weightValue = viewModel.weight / 10
        let abilitiesText = viewModel.abilities.joined(separator: ", ")
        
        heightParameterValueLabel.text = "\(heightValue) mm"
        weightParameterValueLabel.text = "\(weightValue) kg"
        powerParameterValueLabel.text = "\(abilitiesText)"
        createAttackParameter(value: viewModel.attack)
        damageParameterValueLabel.text = "\(viewModel.damage)"
        generalInfoTextView.text = viewModel.description
    }
}

// MARK: - Setup UI
extension AboutContainerView {
    private func setupPokemonParametersLabels() {
        createParametersLabels(labelName: heightParameterTitleLabel, text: "\(AppConstants.AboutContainerView.heightParameter):", textColor: .black)
        createParametersLabels(labelName: weightParameterTitleLabel, text: "\(AppConstants.AboutContainerView.weightParameter):", textColor: .black)
        createParametersLabels(labelName: powerParameterTitleLabel, text: "\(AppConstants.AboutContainerView.powerParameter):", textColor: .black)
        createParametersLabels(labelName: attackParameterTitleLabel, text: "\(AppConstants.AboutContainerView.attackParameter):", textColor: .black)
        createParametersLabels(labelName: damageParameterTitleLabel, text: "\(AppConstants.AboutContainerView.damageParameter):", textColor: .black)
        
        createParametersLabels(labelName: heightParameterValueLabel, text: "", textColor: .gray)
        createParametersLabels(labelName: weightParameterValueLabel, text: "", textColor: .gray)
        createParametersLabels(labelName: powerParameterValueLabel, text: "", textColor: .gray)
        createParametersLabels(labelName: damageParameterValueLabel, text: "", textColor: .gray)
        
        self.addSubview(heightParameterTitleLabel)
        self.addSubview(weightParameterTitleLabel)
        self.addSubview(powerParameterTitleLabel)
        self.addSubview(attackParameterTitleLabel)
        self.addSubview(attackParameterValueLabel)
        self.addSubview(damageParameterTitleLabel)
        self.addSubview(heightParameterValueLabel)
        self.addSubview(weightParameterValueLabel)
        self.addSubview(powerParameterValueLabel)
        self.addSubview(damageParameterValueLabel)
    }
    
    private func setupGeneralInfoTextView() {
        generalInfoTextView.overrideUserInterfaceStyle = .light
        generalInfoTextView.textContainerInset = .zero
        generalInfoTextView.textContainer.lineFragmentPadding = 0
        
        if let customFont = UIFont(name: AppConstants.Fonts.latoRegular, size: 13) {
            generalInfoTextView.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
            generalInfoTextView.adjustsFontForContentSizeCategory = true
        }
        
        self.addSubview(generalInfoTextView)
    }
}

// MARK: - Setup Constraints

extension AboutContainerView {
    private func setupConstraints() {
        heightParameterTitleLabel.addConstraints(to_view: self, [
            .top(anchor: self.topAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: heightParameterValueLabel.leadingAnchor, constant: 10)
        ])
        weightParameterTitleLabel.addConstraints(to_view: self, [
            .top(anchor: heightParameterTitleLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: weightParameterValueLabel.leadingAnchor, constant: 10)
        ])
        powerParameterTitleLabel.addConstraints(to_view: self, [
            .top(anchor: weightParameterTitleLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: powerParameterValueLabel.leadingAnchor, constant: 10)
        ])
        attackParameterTitleLabel.addConstraints(to_view: self, [
            .top(anchor: powerParameterTitleLabel.bottomAnchor, constant: 40),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: attackParameterValueLabel.leadingAnchor, constant: 10)
        ])
        damageParameterTitleLabel.addConstraints(to_view: self, [
            .top(anchor: attackParameterTitleLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: damageParameterValueLabel.leadingAnchor, constant: 16)
        ])
        
        heightParameterValueLabel.addConstraints(to_view: self, [
            .top(anchor: self.topAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 120),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        weightParameterValueLabel.addConstraints(to_view: self, [
            .top(anchor: heightParameterTitleLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 120),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        powerParameterValueLabel.addConstraints(to_view: self, [
            .top(anchor: weightParameterTitleLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 120),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        attackParameterValueLabel.addConstraints(to_view: self, [
            .top(anchor: powerParameterValueLabel.bottomAnchor, constant: 40),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 120),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        damageParameterValueLabel.addConstraints(to_view: self, [
            .top(anchor: attackParameterValueLabel.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 120),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        
        generalInfoTextView.addConstraints(to_view: self, [
            .top(anchor: damageParameterTitleLabel.bottomAnchor, constant: 20),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: self.trailingAnchor, constant: 16),
            .bottom(anchor: self.bottomAnchor, constant: 20)
        ])
    }
}
