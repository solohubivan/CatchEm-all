//
//  DetailedHerosInfoVC.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 10.06.2024.
//

import UIKit

class DetailedHerosInfoVC: UIViewController {
    
    private var goBackButton = UIButton(type: .custom)
    private var herosNameLabel = UILabel()
    private var herosImageView = UIImageView()
    private var herosInfoStackView = UIStackView()
    private var herosHeightLabel = UILabel()
    private var herosWeightLabel = UILabel()
    private var herosPowerLabel = UILabel()
    private var herosAttackLabel = UILabel()
    private var herosDamageLabel = UILabel()
    private var allHerosInfoTextView = UITextView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    // MARK: - @objc methods
    
    @objc private func backToMain() {
        self.dismiss(animated: true)
    }
    
    // MARK: - Private methods
    
    private func createParametersLabels(labelName: UILabel, parametersText: String, textColor: UIColor) {
        labelName.text = parametersText
        labelName.textColor = textColor
        labelName.font = UIFont(name: "Lato-Regular", size: 13)
        labelName.textAlignment = .left
    }
    
}

// MARK: - Setup UI

extension DetailedHerosInfoVC {
    private func setupUI() {
        setupGoBackButton()
        setupHerosNameLabel()
        setupHerosImageView()
        setupButtonsStackView()
        setupAboutParametersInfoLabels()
        setupHerosHeightLabel()
    }
    
    private func setupGoBackButton() {
        let buttonImage = UIImage(named: "leftArrow")
        goBackButton.setImage(buttonImage, for: .normal)
        goBackButton.imageView?.contentMode = .scaleAspectFit
        goBackButton.addTarget(self, action: #selector(backToMain), for: .touchUpInside)
        
        view.addSubview(goBackButton)
        goBackButton.addConstraints(to_view: view, [
            .top(anchor: view.topAnchor, constant: 65),
            .leading(anchor: view.leadingAnchor, constant: 24),
            .height(constant: 16),
            .width(constant: 16)
        ])
    }
    
    private func setupHerosNameLabel() {
        herosNameLabel.text  = "Chua"
        herosNameLabel.textColor = UIColor.hex231F20
        herosNameLabel.font = UIFont(name: "Lato-Bold", size: 24)
        herosNameLabel.textAlignment = .left
        
        view.addSubview(herosNameLabel)
        herosNameLabel.addConstraints(to_view: view, [
            .top(anchor: goBackButton.bottomAnchor, constant: 54),
            .leading(anchor: view.leadingAnchor, constant: 24),
            .trailing(anchor: view.trailingAnchor, constant: 24),
            .height(constant: 26)
        ])
    }
    
    private func setupHerosImageView() {
        herosImageView.image = UIImage(named: "mainVCBackground")
        herosImageView.contentMode = .scaleAspectFit
        
        view.addSubview(herosImageView)
        herosImageView.addConstraints(to_view: view, [
            .top(anchor: herosNameLabel.bottomAnchor, constant: 40),
            .height(constant: 198)
        ])
    }
    
    private func setupButtonsStackView() {
        herosInfoStackView.axis = .horizontal
        herosInfoStackView.distribution = .equalSpacing
        herosInfoStackView.spacing = 16

        let buttonsTitles = ["About", "Stats", "Evolution", "Moves"]
            
        for title in buttonsTitles {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            herosInfoStackView.addArrangedSubview(button)
        }
            
        view.addSubview(herosInfoStackView)
        herosInfoStackView.addConstraints(to_view: view, [
            .top(anchor: herosImageView.bottomAnchor, constant: 16),
            .leading(anchor: view.leadingAnchor, constant: 24),
            .trailing(anchor: view.trailingAnchor, constant: 24),
            .height(constant: 44)
        ])
    }

    private func setupAboutParametersInfoLabels() {
        let herosParametersInfo = ["Height", "Weight", "Power", "Attack", "Damage"]
        var labels = [UILabel]()
        
        for _ in herosParametersInfo {
            labels.append(UILabel())
        }
        
        for (index, parameter) in herosParametersInfo.enumerated() {
                let label = labels[index]
            createParametersLabels(labelName: label, parametersText: parameter, textColor: .black)
                view.addSubview(label)
        }
        
        for (index, label) in labels.enumerated() {
            if index == 0 {
                label.addConstraints(to_view: view, [
                    .top(anchor: herosInfoStackView.bottomAnchor, constant: 24),
                    .leading(anchor: view.leadingAnchor, constant: 24),
                    .height(constant: 13)
                ])
            } else {
                label.addConstraints(to_view: view, [
                    .top(anchor: labels[index - 1].bottomAnchor, constant: 24),
                    .leading(anchor: view.leadingAnchor, constant: 24),
                    .height(constant: 13)
                ])
            }
        }
    }
    
    private func setupHerosHeightLabel() {
        createParametersLabels(labelName: herosHeightLabel, parametersText: "1120 mm", textColor: UIColor.hex50555C)
        view.addSubview(herosHeightLabel)
        herosHeightLabel.addConstraints(to_view: view, [
            .top(anchor: herosInfoStackView.bottomAnchor, constant: 24),
            .leading(anchor: view.leadingAnchor, constant: 125),
            .trailing(anchor: view.trailingAnchor, constant: 16),
            .height(constant: 13)
        ])
    }

}
