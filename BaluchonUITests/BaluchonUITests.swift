//
//  BaluchonUITests.swift
//  BaluchonUITests
//
//  Created by Paul Ghibeaux on 21/08/2021.
//

import XCTest
@testable import Baluchon

class BaluchonUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
  
    
    
    func testTabBarController() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars.firstMatch.buttons.element(boundBy: 1).tap()
        app.tabBars.firstMatch.buttons.element(boundBy: 2).tap()
        app.tabBars.firstMatch.buttons.element(boundBy: 1).tap()
        app.tabBars.firstMatch.buttons.element(boundBy: 2).tap()
    }
    
    func testTranslateViewController() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        XCTAssert(app.textFields["translateTextField"].exists, "test text field doesn't exist" )
        let tf = app.textFields["translateTextField"]
        tf.tap()    // must give text field keyboard focus!
        tf.typeText("Hola!")
        app.keyboards.buttons["Send"].tap()

        XCTAssert( tf.exists, "tf exists" )   // text field still exists
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    
    func testConvertController() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars.firstMatch.buttons.element(boundBy: 1).tap()

        XCTAssert(app.textFields["changeTextField"].exists, "test text field doesn't exist" )
        let tf = app.textFields["changeTextField"]
        tf.tap()    // must give text field keyboard focus!
        tf.typeText("35")
        app.buttons["conversionButton"].tap()
                
        XCTAssert( tf.exists, "tf exists" )   // text field still exists
    }
    func testWeatherController() throws {
        let app = XCUIApplication()
        app.launch()

        app.tabBars.firstMatch.buttons.element(boundBy: 2).tap()
        XCTAssert(app.textFields["CitySearchField"].exists, "test text field doesn't exist" )
        let tf = app.textFields["CitySearchField"]
        tf.tap()
        tf.typeText("Tokyo")// must give text field keyboard focus!
        app.buttons["searchButton"].tap()
        app.buttons["locationButton"].tap()

        tf.tap()
        
        XCTAssert(tf.exists, "tf exists")   // text field still exists
    }
    
    
 

    

    
    
}

