//
//  AppConstants.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 30.05.2024.
//

import Foundation

enum AppConstants {
    
    enum Fonts {
        static let latoBold = "Lato-Bold"
        static let latoRegular = "Lato-Regular"
        static let latoSemibold = "Lato-Semibold"
    }
    
    enum ImageNames {
        static let mainVCBGImage: String = "mainVCBackground"
        static let fireSpin: String = "fireSpin"
        static let leftArrow: String = "leftArrow"
    }
    
    enum ButtonTitleLabels {
        static let aboutButton: String = "About"
        static let statsButton: String = "Stats"
        static let evolutionButton: String = "Evolution"
        static let movesButton: String = "Moves"
    }
    
    enum Identifiers {
        static let mainVCCellID: String = "MainVCCellId"
    }
    
    enum MainViewController {
        static let mainTitleText: String = "Know Them All"
    }
    
    enum AboutContainerView {
        static let heightParameter: String = "Height"
        static let weightParameter: String = "Weight"
        static let powerParameter: String = "Power"
        static let attackParameter: String = "Attack"
        static let damageParameter: String = "Damage"
    }
    
    enum StatsContainerView {
        static let hpParameter: String = "HP"
        static let attackParameter: String = "Attack"
        static let specialAttackParameter: String = "Special attack"
        static let defenseParameter: String = "Defense"
        static let specialDefenseParameter: String = "Special defense"
        static let speedParameter: String = "Speed"
    }
    
    enum EvolutionContainerView {
        static let lastEvolutionStageLabelText: String = "It is the last evolution stage yet"
        static let currentEvolutionParameter: String = "Current evolution"
        static let nextEvolutionParameter: String = "Next evolution"
        static let triggerNextEvolutionParameter: String = "Trigger for next evolution"
        static let minimalLevelForEvolutionParameter: String = "Minimal level for evolution"
        static let placeForNextEvolutionParameter: String = "Place for next evolution"
        static let defaultValue: String = "Unknown information yet :("
    }
    
    enum MovesContainerView {
        static let titleLabelText: String = "There are available moves"
    }
    
    enum ObjectsIdentifier {
        static let mainTitleLabel: String = "MainTitleLabel"
        static let presentPokemonsCollectionView: String = "PresentPokemonsCollectionView"
        static let goBackButton: String = "BackButton"
        static let nameLabel: String = "HerosNameLabel"
        static let pokemonImageView: String = "PokemonImageView"
        static let pokemonsInfoModeButtonsStackView: String = "PokemonsInfoModeButtonsStackView"
        
        static let heightParameterTitleLabel: String = "HeightParameterTitleLabel"
        static let weightParameterTitleLabel: String = "WeightParameterTitleLabel"
        static let powerParameterTitleLabel: String = "PowerParameterTitleLabel"
        static let attackParameterTitleLabel: String = "AttackParameterTitleLabel"
        static let damageParameterTitleLabel: String = "DamageParameterTitleLabel"
        static let heightParameterValueLabel: String = "HeightParameterValueLabel"
        static let weightParameterValueLabel: String = "WeightParameterValueLabel"
        static let powerParameterValueLabel: String = "PowerParameterValueLabel"
        static let attackParameterValueLabel: String = "AttackParameterValueLabel"
        static let damageParameterValueLabel: String = "DamageParameterValueLabel"
        static let generalInfoTextView: String = "GeneralInfoTextView"
        
        static let pokemonHPTitleLabel: String = "PokemonHPTitleLabel"
        static let pokemonAttackTitleLabel: String = "PokemonAttackTitleLabel"
        static let pokemonSpecialAttackTitleLabel: String = "PokemonSpecialAttackTitleLabel"
        static let pokemonDefenseTitleLabel: String = "PokemonDefenseTitleLabel"
        static let pokemonSpecialDefenseTitleLabel: String = "PokemonSpecialDefenseTitleLabel"
        static let pokemonSpeedTitleLabel: String = "PokemonSpeedTitleLabel"
        static let pokemonHPValueLabel: String = "PokemonHPValueLabel"
        static let pokemonAttackValueLabel: String = "PokemonAttackValueLabel"
        static let pokemonSpecialAttackValueLabel: String = "PokemonSpecialAttackValueLabel"
        static let pokemonDefenseValueLabel: String = "PokemonDefenseValueLabel"
        static let pokemonSpecialDefenseValueLabel: String = "PokemonSpecialDefenseValueLabel"
        static let pokemonSpeedValueLabel: String = "PokemonSpeedValueLabel"
        
        static let currentEvolutionNameTitleLabel: String = "CurrentEvolutionNameTitleLabel"
        static let nextEvolutionsNamesTitleLabel: String = "NextEvolutionsNamesTitleLabel"
        static let triggerForNextEvolutionStageTitleLabel: String = "TriggerForNextEvolutionStageTitleLabel"
        static let minLevelForNextEvolutionStageTitleLabel: String = "MinLevelForNextEvolutionStageTitleLabel"
        static let placeForNextEvolutionTitleLabel: String = "PlaceForNextEvolutionTitleLabel"
        static let currentEvolutionNameValueLabel: String = "CurrentEvolutionNameValueLabel"
        static let nextEvolutionsNamesValueLabel: String = "NextEvolutionsNamesValueLabel"
        static let triggerForNextEvolutionStageValueLabel: String = "TriggerForNextEvolutionStageValueLabel"
        static let minLevelForNextEvolutionStageValueLabel: String = "MinLevelForNextEvolutionStageValueLabel"
        static let placeForNextEvolutionValueLabel: String = "PlaceForNextEvolutionValueLabel"
        
        static let movesTitleLabel: String = "MovesTitleLabel"
        static let movesInfoTextView: String = "MovesInfoTextView"
    }
}
