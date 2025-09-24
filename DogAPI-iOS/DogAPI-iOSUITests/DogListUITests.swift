//
//  DogListUITests.swift
//  DogAPI-iOS
//
//  Created by Sévio Basilio Corrêa on 24/09/25.
//

import XCTest

final class DogListUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testUserCanViewDogDetails() {
        let dogImage = app.images["dogImageView"]
        
        // Espera a imagem existir e toca nela
        XCTAssertTrue(dogImage.waitForExistence(timeout: 5))
        dogImage.tap()
        
        // Confirma que a tela de detalhes apareceu
        let breedLabel = app.staticTexts["breedLabel"]
        XCTAssertTrue(breedLabel.waitForExistence(timeout: 5))
    }
}
