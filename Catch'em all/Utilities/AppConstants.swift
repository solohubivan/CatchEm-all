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
}
