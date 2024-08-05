//
//  Catch_em_allTests.swift
//  Catch'em allTests
//
//  Created by Ivan Solohub on 05.08.2024.
//

import XCTest
@testable import Catch_em_all

final class ApiDataManagerTests: XCTestCase {
    
    var apiDataManager: ApiDataManager?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        apiDataManager = ApiDataManager()
    }
    
    override func tearDownWithError() throws {
        apiDataManager = nil
        try super.tearDownWithError()
    }
    
    func testPokemonApiDataURL() {
        // Given
        let expectedURL = "https://pokeapi.co/api/v2/pokemon"
        // When
        let url = apiDataManager?.getNextPageUrl()
        // Then
        XCTAssertEqual(url, expectedURL)
    }
    
    func testPokemonDetailURL() {
        // Given
        let pokemon = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
        // When
        let detailURL = apiDataManager?.createPokemonDetailURL(for: pokemon)
        let expectedURL = URL(string: "https://pokeapi.co/api/v2/pokemon/1/")
        // Then
        XCTAssertEqual(detailURL, expectedURL)
    }
    
    func testPokemonDetailURL2() {
        let pokemon = Pokemon(name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon/25/")
        let detailURL = apiDataManager?.createPokemonDetailURL(for: pokemon)
        let expectedURL = URL(string: "https://pokeapi.co/api/v2/pokemon/25/")
        XCTAssertEqual(detailURL, expectedURL)
    }
    
    func testPokemonDetailURLFailure() {
        let pokemon = Pokemon(name: "charizard", url: "https://pokeapi.co/api/v2/pokemon/6/")
        let detailURL = apiDataManager?.createPokemonDetailURL(for: pokemon)
        let expectedURL = URL(string: "https://pokeapi.co/api/v2/pokemon/66/")
        XCTAssertNotEqual(detailURL, expectedURL)
    }
}
