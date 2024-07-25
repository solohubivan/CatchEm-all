//
//  DetailInfoPokemonVC.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 10.06.2024.
//
import UIKit

class DetailInfoPokemonVC: UIViewController {
    
    private var goBackButton = UIButton(type: .custom)
    private var nameLabel = UILabel()
    private var pokemonImageView = UIImageView()
    private var pokemonsInfoModeButtonsStackView = UIStackView()
    
    private var infoModesButtons: [UIButton] = []
    private var infoModeButtonsUnderscore: [UIView] = []
    private var selectedInfoModeButton: UIButton?
    private var underscoreLineView = UIView()
    
    private var aboutContainerView = AboutContainerView()
    private var statsContainerView = StatsContainerView()
    private var evolutionContainerView = EvolutionContainerView()
    private var movesContainerView = MovesContainerView()

    var viewModel: DetailInfoPokemonViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        guard let viewModel = viewModel else { return }
        updateUI(with: viewModel)
        selectedButton(infoModesButtons.first)
    }
    
    // MARK: - @objc methods
    
    @objc private func backToMain() {
        self.dismiss(animated: true)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        selectedButton(sender)
    }
    
    // MARK: - Private methods
    
    private func selectedButton(_ button: UIButton?) {
        infoModesButtons.forEach { $0.setTitleColor(.black, for: .normal) }
        button?.setTitleColor(.red, for: .normal)
        
        infoModeButtonsUnderscore.forEach { $0.backgroundColor = .clear }
        guard let button = button, let index = infoModesButtons.firstIndex(of: button) else { return }
        button.setTitleColor(.red, for: .normal)
        infoModeButtonsUnderscore[index].backgroundColor = .red
        
        selectedInfoModeButton = button
        if let viewModel = viewModel {
            viewModel.currentMode = InfoMode(rawValue: button.tag) ?? .about
            updateVisibleContainer(for: viewModel.currentMode)
        }
    }
    
    private func updateVisibleContainer(for mode: InfoMode) {
        aboutContainerView.isHidden = true
        statsContainerView.isHidden = true
        evolutionContainerView.isHidden = true
        movesContainerView.isHidden = true
            
        guard let viewModel = viewModel else { return }
        switch mode {
        case .about:
            aboutContainerView.isHidden = false
            aboutContainerView.updateAboutContainerView(with: viewModel.aboutInfo)
        case .stats:
            statsContainerView.isHidden = false
            statsContainerView.updateStatsContainerView(with: viewModel.stats)
        case .evolution:
            evolutionContainerView.isHidden = false
            evolutionContainerView.updateEvolutionContainerView(with: viewModel.evolution)
        case .moves:
            movesContainerView.isHidden = false
            movesContainerView.updateMovesInfoTextView(with: viewModel.moves)
        }
    }
    
    private func updateUI(with viewModel: DetailInfoPokemonViewModel) {
        nameLabel.text = viewModel.name
        
        viewModel.loadImage { [weak self] image in
            self?.pokemonImageView.image = image
        }
    }
    
    private func createParametersLabels(labelName: UILabel, parametersText: String, textColor: UIColor) {
        labelName.text = parametersText
        labelName.textColor = textColor
        labelName.setCustomFont(name: AppConstants.Fonts.latoRegular, size: 13, textStyle: .body)
        
        labelName.textAlignment = .left
    }
}

// MARK: - Setup UI

extension DetailInfoPokemonVC {
    private func setupUI() {
        view.backgroundColor = .white
        setupGoBackButton()
        setupHerosNameLabel()
        setupHerosImageView()
        setupPokemonsInfoModeButtonsStackView()
        createUnderscoreLines()
        setupInfoModesViewContainers()
        
        setupConstraints()
    }
    
    private func setupGoBackButton() {
        let buttonImage = UIImage(named: AppConstants.ImageNames.leftArrow)
        goBackButton.setImage(buttonImage, for: .normal)
        goBackButton.imageView?.contentMode = .scaleAspectFit
        goBackButton.addTarget(self, action: #selector(backToMain), for: .touchUpInside)
        
        view.addSubview(goBackButton)
    }
    
    private func setupHerosNameLabel() {
        nameLabel.textColor = UIColor.hex231F20
        nameLabel.setCustomFont(name: AppConstants.Fonts.latoBold, size: 24, textStyle: .title1)
        nameLabel.textAlignment = .left
        
        view.addSubview(nameLabel)
    }
    
    private func setupHerosImageView() {
        pokemonImageView.image = UIImage(named: AppConstants.ImageNames.mainVCBGImage)
        pokemonImageView.contentMode = .scaleAspectFit
        
        view.addSubview(pokemonImageView)
    }
    
    private func setupPokemonsInfoModeButtonsStackView() {
        pokemonsInfoModeButtonsStackView.axis = .horizontal
        pokemonsInfoModeButtonsStackView.distribution = .equalSpacing
        pokemonsInfoModeButtonsStackView.spacing = 16

        let buttonsTitles = [AppConstants.ButtonTitleLabels.aboutButton,
                             AppConstants.ButtonTitleLabels.statsButton,
                             AppConstants.ButtonTitleLabels.evolutionButton,
                             AppConstants.ButtonTitleLabels.movesButton]
            
        for (index, title) in buttonsTitles.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont(name: AppConstants.Fonts.latoRegular, size: 14)
            button.titleLabel?.textAlignment = .center
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.tag = index
            
            if let customFont = UIFont(name: AppConstants.Fonts.latoRegular, size: 14) {
                button.titleLabel?.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
                button.titleLabel?.adjustsFontForContentSizeCategory = true
            }
            
            infoModesButtons.append(button)
            pokemonsInfoModeButtonsStackView.addArrangedSubview(button)
        }
        view.addSubview(pokemonsInfoModeButtonsStackView)
    }
    
    private func createUnderscoreLines() {
        underscoreLineView.backgroundColor = UIColor.hexDADADA
        view.addSubview(underscoreLineView)
 
        for button in infoModesButtons {
            let selfLine = UIView()
            view.addSubview(selfLine)
            selfLine.addConstraints(to_view: view, [
                .top(anchor: pokemonsInfoModeButtonsStackView.bottomAnchor, constant: .zero),
                .height(constant: 1),
                .leading(anchor: button.leadingAnchor, constant: -10),
                .trailing(anchor: button.trailingAnchor, constant: -10)
            ])
            infoModeButtonsUnderscore.append(selfLine)
        }
    }
    
    private func setupInfoModesViewContainers() {
        view.addSubview(aboutContainerView)
        view.addSubview(statsContainerView)
        view.addSubview(evolutionContainerView)
        view.addSubview(movesContainerView)
    }
    
    private func setupConstraints() {
        goBackButton.addConstraints(to_view: view, [
            .top(anchor: view.topAnchor, constant: 65),
            .leading(anchor: view.leadingAnchor, constant: 24),
            .height(constant: 16),
            .width(constant: 16)
        ])
        
        nameLabel.addConstraints(to_view: view, [
            .top(anchor: goBackButton.bottomAnchor, constant: 54),
            .leading(anchor: view.leadingAnchor, constant: 24),
            .trailing(anchor: view.trailingAnchor, constant: 24),
            .height(constant: 26)
        ])
        
        pokemonImageView.addConstraints(to_view: view, [
            .top(anchor: nameLabel.bottomAnchor, constant: 40),
            .height(constant: 198)
        ])
        
        pokemonsInfoModeButtonsStackView.addConstraints(to_view: view, [
            .top(anchor: pokemonImageView.bottomAnchor, constant: 16),
            .leading(anchor: view.leadingAnchor, constant: 40),
            .trailing(anchor: view.trailingAnchor, constant: 40),
            .height(constant: 25)
        ])

        underscoreLineView.addConstraints(to_view: view, [
            .top(anchor: pokemonsInfoModeButtonsStackView.bottomAnchor, constant: 0),
            .leading(anchor: view.leadingAnchor, constant: 24),
            .trailing(anchor: view.trailingAnchor, constant: 24),
            .height(constant: 1)
        ])
        
        aboutContainerView.addConstraints(to_view: view, [
            .top(anchor: underscoreLineView.bottomAnchor, constant: 0)
        ])
            
        statsContainerView.addConstraints(to_view: view, [
            .top(anchor: underscoreLineView.bottomAnchor, constant: 0)
        ])
        
        evolutionContainerView.addConstraints(to_view: view, [
            .top(anchor: underscoreLineView.bottomAnchor, constant: 0)
        ])
        
        movesContainerView.addConstraints(to_view: view, [
            .top(anchor: underscoreLineView.bottomAnchor, constant: 0)
        ])
    }
}
