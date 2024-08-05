//
//  Catch_em_allUITests.swift
//  Catch'em allUITests
//
//  Created by Ivan Solohub on 05.08.2024.
//

import XCTest

final class Catch_em_allUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
        super.tearDown()
    }
    
    func testMainVCObjectsExists() {
        let titleLabel = app.staticTexts["MainTitleLabel"]
        let collectionView = app.collectionViews["PresentPokemonsCollectionView"]
        
        XCTAssertTrue(titleLabel.exists)
        XCTAssertTrue(collectionView.exists)
    }
    
    func testDetailInfoVCObjectsExists() {
        let collectionView = app.collectionViews["PresentPokemonsCollectionView"]
        let fifthCell = collectionView.cells.element(boundBy: 5)
        let backButton = app.buttons["BackButton"]
        let nameLabel = app.staticTexts["HerosNameLabel"]
        let imageView = app.images["PokemonImageView"]
        let stackView = app.otherElements["PokemonsInfoModeButtonsStackView"]
        
        sleep(1)
        
        XCTAssertTrue(fifthCell.exists)
        fifthCell.tap()
        sleep(1)
        
        XCTAssertTrue(backButton.exists)
        XCTAssertTrue(nameLabel.exists)
        XCTAssertTrue(imageView.exists)
        XCTAssertTrue(stackView.exists)
    }
    
    func testTapStatsButtonInDetailInfoVC() {
        let collectionView = app.collectionViews["PresentPokemonsCollectionView"]
        let fifthCell = collectionView.cells.element(boundBy: 5)
        sleep(1)
        XCTAssertTrue(fifthCell.exists)
        fifthCell.tap()
        sleep(1)
        let stackView = app.otherElements["PokemonsInfoModeButtonsStackView"]
        XCTAssertTrue(stackView.exists)
                
        let statsButton = app.buttons["StatsButton"]
        XCTAssertTrue(statsButton.exists)
                
        statsButton.tap()
        
        let hpTitleLabel = app.staticTexts["PokemonHPTitleLabel"]
        let attackTitleLabel = app.staticTexts["PokemonAttackTitleLabel"]
        let specialAttackTitleLabel = app.staticTexts["PokemonSpecialAttackTitleLabel"]
        let defenseTitleLabel = app.staticTexts["PokemonDefenseTitleLabel"]
        let specialDefenseTitleLabel = app.staticTexts["PokemonSpecialDefenseTitleLabel"]
        let speedTitleLabel = app.staticTexts["PokemonSpeedTitleLabel"]
        let hpValueLabel = app.staticTexts["PokemonHPValueLabel"]
        let attackValueLabel = app.staticTexts["PokemonAttackValueLabel"]
        let specialAttackValueLabel = app.staticTexts["PokemonSpecialAttackValueLabel"]
        let defenseValueLabel = app.staticTexts["PokemonDefenseValueLabel"]
        let specialDefenseValueLabel = app.staticTexts["PokemonSpecialDefenseValueLabel"]
        let speedValueLabel = app.staticTexts["PokemonSpeedValueLabel"]
                
        XCTAssertTrue(hpTitleLabel.exists)
        XCTAssertTrue(attackTitleLabel.exists)
        XCTAssertTrue(specialAttackTitleLabel.exists)
        XCTAssertTrue(defenseTitleLabel.exists)
        XCTAssertTrue(specialDefenseTitleLabel.exists)
        XCTAssertTrue(speedTitleLabel.exists)
        XCTAssertTrue(hpValueLabel.exists)
        XCTAssertTrue(attackValueLabel.exists)
        XCTAssertTrue(specialAttackValueLabel.exists)
        XCTAssertTrue(defenseValueLabel.exists)
        XCTAssertTrue(specialDefenseValueLabel.exists)
        XCTAssertTrue(speedValueLabel.exists)
    }
    
    func testTapEvolutionButtonInDetailInfoVC() {
        let collectionView = app.collectionViews["PresentPokemonsCollectionView"]
        let fifthCell = collectionView.cells.element(boundBy: 5)
            
        sleep(1)
            
        XCTAssertTrue(fifthCell.exists)
        fifthCell.tap()
        sleep(1)
            
        let stackView = app.otherElements["PokemonsInfoModeButtonsStackView"]
        XCTAssertTrue(stackView.exists)
        
        let evolutionButton = app.buttons["EvolutionButton"]
        XCTAssertTrue(evolutionButton.exists)
        
        evolutionButton.tap()
    
        let currentEvolutionNameTitleLabel = app.staticTexts["CurrentEvolutionNameTitleLabel"]
        let nextEvolutionsNamesTitleLabel = app.staticTexts["NextEvolutionsNamesTitleLabel"]
        let triggerForNextEvolutionStageTitleLabel = app.staticTexts["TriggerForNextEvolutionStageTitleLabel"]
        let minLevelForNextEvolutionStageTitleLabel = app.staticTexts["MinLevelForNextEvolutionStageTitleLabel"]
        let placeForNextEvolutionTitleLabel = app.staticTexts["PlaceForNextEvolutionTitleLabel"]
            
        let currentEvolutionNameValueLabel = app.staticTexts["CurrentEvolutionNameValueLabel"]
        let nextEvolutionsNamesValueLabel = app.staticTexts["NextEvolutionsNamesValueLabel"]
        let triggerForNextEvolutionStageValueLabel = app.staticTexts["TriggerForNextEvolutionStageValueLabel"]
        let minLevelForNextEvolutionStageValueLabel = app.staticTexts["MinLevelForNextEvolutionStageValueLabel"]
        let placeForNextEvolutionValueLabel = app.staticTexts["PlaceForNextEvolutionValueLabel"]
            
        XCTAssertTrue(currentEvolutionNameTitleLabel.exists)
        XCTAssertTrue(nextEvolutionsNamesTitleLabel.exists)
        XCTAssertTrue(triggerForNextEvolutionStageTitleLabel.exists)
        XCTAssertTrue(minLevelForNextEvolutionStageTitleLabel.exists)
        XCTAssertTrue(placeForNextEvolutionTitleLabel.exists)
            
        XCTAssertTrue(currentEvolutionNameValueLabel.exists)
        XCTAssertTrue(nextEvolutionsNamesValueLabel.exists)
        XCTAssertTrue(triggerForNextEvolutionStageValueLabel.exists)
        XCTAssertTrue(minLevelForNextEvolutionStageValueLabel.exists)
        XCTAssertTrue(placeForNextEvolutionValueLabel.exists)
    }
        
    func testTapMovesButtonInDetailInfoVC() {
        let collectionView = app.collectionViews["PresentPokemonsCollectionView"]
        let fifthCell = collectionView.cells.element(boundBy: 5)
            
        sleep(1)
            
        XCTAssertTrue(fifthCell.exists)
        fifthCell.tap()
        sleep(1)
            
        let stackView = app.otherElements["PokemonsInfoModeButtonsStackView"]
        XCTAssertTrue(stackView.exists)
        
        let movesButton = app.buttons["MovesButton"]
        XCTAssertTrue(movesButton.exists)
        
        movesButton.tap()
        
        let titleLabel = app.staticTexts["MovesTitleLabel"]
        let movesInfoTextView = app.textViews["MovesInfoTextView"]
        
        XCTAssertTrue(titleLabel.exists)
        XCTAssertTrue(movesInfoTextView.exists)
    }
    
    func testTapAboutButtonInDetailInfoVC() {
        let collectionView = app.collectionViews["PresentPokemonsCollectionView"]
        let fifthCell = collectionView.cells.element(boundBy: 5)
            
        sleep(1)
            
        XCTAssertTrue(fifthCell.exists)
        fifthCell.tap()
        sleep(1)
            
        let stackView = app.otherElements["PokemonsInfoModeButtonsStackView"]
        XCTAssertTrue(stackView.exists)
            
        let aboutButton = app.buttons["AboutButton"]
        XCTAssertTrue(aboutButton.exists)
        
        aboutButton.tap()
            
        let heightParameterTitleLabel = app.staticTexts["HeightParameterTitleLabel"]
        let weightParameterTitleLabel = app.staticTexts["WeightParameterTitleLabel"]
        let powerParameterTitleLabel = app.staticTexts["PowerParameterTitleLabel"]
        let attackParameterTitleLabel = app.staticTexts["AttackParameterTitleLabel"]
        let damageParameterTitleLabel = app.staticTexts["DamageParameterTitleLabel"]
            
        let heightParameterValueLabel = app.staticTexts["HeightParameterValueLabel"]
        let weightParameterValueLabel = app.staticTexts["WeightParameterValueLabel"]
        let powerParameterValueLabel = app.staticTexts["PowerParameterValueLabel"]
        let attackParameterValueLabel = app.staticTexts["AttackParameterValueLabel"]
        let damageParameterValueLabel = app.staticTexts["DamageParameterValueLabel"]
        let generalInfoTextView = app.textViews["GeneralInfoTextView"]
            
        XCTAssertTrue(heightParameterTitleLabel.exists)
        XCTAssertTrue(weightParameterTitleLabel.exists)
        XCTAssertTrue(powerParameterTitleLabel.exists)
        XCTAssertTrue(attackParameterTitleLabel.exists)
        XCTAssertTrue(damageParameterTitleLabel.exists)
            
        XCTAssertTrue(heightParameterValueLabel.exists)
        XCTAssertTrue(weightParameterValueLabel.exists)
        XCTAssertTrue(powerParameterValueLabel.exists)
        XCTAssertTrue(attackParameterValueLabel.exists)
        XCTAssertTrue(damageParameterValueLabel.exists)
        XCTAssertTrue(generalInfoTextView.exists)
    }
}
