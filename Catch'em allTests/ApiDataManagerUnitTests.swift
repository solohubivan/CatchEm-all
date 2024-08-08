//
//  ApiDataManagerUnitTests.swift
//  Catch'em allTests
//
//  Created by Ivan Solohub on 05.08.2024.
//

import XCTest
@testable import Catch_em_all

final class ApiDataManagerUnitTests: XCTestCase {
    
    var apiDataManager: ApiDataManager?

    override func setUp() {
        super.setUp()
        apiDataManager = ApiDataManager()
    }
    
    override func tearDownWithError() throws {
        apiDataManager = nil
        try super.tearDownWithError()
    }
    
    func testGetNextPageUrlReturnsCorrectURL() {
        // Given
        let expectedURL = "https://pokeapi.co/api/v2/pokemon"
        // When
        let url = apiDataManager?.getNextPageUrl()
        // Then
        XCTAssertEqual(url, expectedURL)
    }
    
    func testCreatePokemonDetailURLReturnsCorrectURL() {
        // Given
        let pokemon = Pokemon(name: "bulbasaur", url: apiDataManager?.createPokemonURL(for: 1) ?? "")
        // When
        let detailURL = apiDataManager?.createPokemonDetailURL(for: pokemon)
        let expectedURL = URL(string: "https://pokeapi.co/api/v2/pokemon/1/")
        // Then
        XCTAssertEqual(detailURL, expectedURL)
    }
        
    func testCreatePokemonDetailURLReturnsCorrectURLForPikachu() {
        let pokemon = Pokemon(name: "pikachu", url: apiDataManager?.createPokemonURL(for: 25) ?? "")
        let detailURL = apiDataManager?.createPokemonDetailURL(for: pokemon)
        let expectedURL = URL(string: "https://pokeapi.co/api/v2/pokemon/25/")
        XCTAssertEqual(detailURL, expectedURL)
    }
        
    func testCreatePokemonDetailURLReturnsIncorrectURLForCharizard() {
        let pokemon = Pokemon(name: "charizard", url: apiDataManager?.createPokemonURL(for: 6) ?? "")
        let detailURL = apiDataManager?.createPokemonDetailURL(for: pokemon)
        let expectedURL = URL(string: "https://pokeapi.co/api/v2/pokemon/66/")
        XCTAssertNotEqual(detailURL, expectedURL)
    }
}
