//
//  AboutContainerView.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 25.06.2024.
//

import UIKit

class AboutContainerView: UIView {

    private var heightParameter = UILabel()
    private var weightParameter = UILabel()
    private var powerParameter = UILabel()
    private var attackParameter = UILabel()
    private var damageParameter = UILabel()
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
    
    private func createParametersLabels(labelName: UILabel) {
        labelName.text = ""
        labelName.textColor = .black
        labelName.font = UIFont(name: "Lato-Regular", size: 13)
        labelName.textAlignment = .left
    }
    
    private func createLabelText(title: String, value: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(title):", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "Lato-Regular", size: 13)!
        ])
            
        let spacing = "             "
        
        let valueText = NSAttributedString(string: "\(spacing)\(value)", attributes: [
            .foregroundColor: UIColor.gray,
            .font: UIFont(name: "Lato-Regular", size: 13)!
        ])
            
        attributedText.append(valueText)
        return attributedText
    }
    
    private func createAttackParameter(value: Int) {
        let attackValue = max(1, min(value / 10, 10))
            
        let attributedString = NSMutableAttributedString(string: "Attack:                ")
            
        for _ in 0..<attackValue {
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: "fireSpin")
            attachment.bounds = CGRect(x: 0, y: -5, width: 20, height: 20)
                
            attributedString.append(NSAttributedString(attachment: attachment))
            attributedString.append(NSAttributedString(string: " "))
        }
            
        attackParameter.attributedText = attributedString
    }

    // MARK: - Public Methods
    
    func updateAboutContainerView(with viewModel: PokemonMainInfoDataModel) {
        let heightValue = viewModel.height * 100
        let weightValue = viewModel.weight / 10
        let abilitiesText = viewModel.abilities.joined(separator: ", ")
        heightParameter.attributedText = createLabelText(title: "Height", value: "\(heightValue) mm")
        weightParameter.attributedText = createLabelText(title: "Weight", value: "\(weightValue) kg")
        powerParameter.attributedText = createLabelText(title: "Power", value: abilitiesText)
        
        createAttackParameter(value: viewModel.attack)
        
        damageParameter.attributedText = createLabelText(title: "Damage", value: "\(viewModel.damage)")
        
        generalInfoTextView.text = viewModel.description
    }
}

// MARK: - Setup UI
extension AboutContainerView {
    private func setupPokemonParametersLabels() {
        createParametersLabels(labelName: heightParameter)
        createParametersLabels(labelName: weightParameter)
        createParametersLabels(labelName: powerParameter)
        createParametersLabels(labelName: attackParameter)
        createParametersLabels(labelName: damageParameter)
        self.addSubview(heightParameter)
        self.addSubview(weightParameter)
        self.addSubview(powerParameter)
        self.addSubview(attackParameter)
        self.addSubview(damageParameter)
    }
    
    private func setupGeneralInfoTextView() {
        generalInfoTextView.overrideUserInterfaceStyle = .light
        generalInfoTextView.textContainerInset = .zero
        generalInfoTextView.textContainer.lineFragmentPadding = 0
        generalInfoTextView.font = UIFont(name: "Lato-Regular", size: 13)
        
        self.addSubview(generalInfoTextView)
    }
}

// MARK: - Setup Constraints

extension AboutContainerView {
    private func setupConstraints() {
        heightParameter.addConstraints(to_view: self, [
            .top(anchor: self.topAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        weightParameter.addConstraints(to_view: self, [
            .top(anchor: heightParameter.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        powerParameter.addConstraints(to_view: self, [
            .top(anchor: weightParameter.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        attackParameter.addConstraints(to_view: self, [
            .top(anchor: powerParameter.bottomAnchor, constant: 40),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        damageParameter.addConstraints(to_view: self, [
            .top(anchor: attackParameter.bottomAnchor, constant: 20),
            .height(constant: 15),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: self.trailingAnchor, constant: 16)
        ])
        generalInfoTextView.addConstraints(to_view: self, [
            .top(anchor: damageParameter.bottomAnchor, constant: 20),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: self.trailingAnchor, constant: 16),
            .bottom(anchor: self.bottomAnchor, constant: 20)
        ])
    }
}
