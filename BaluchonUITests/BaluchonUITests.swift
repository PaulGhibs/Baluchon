//
//  BaluchonUITests.swift
//  BaluchonUITests
//
//  Created by Paul Ghibeaux on 21/08/2021.
// swiftlint:disable all


import XCTest
@testable import Baluchon

class BaluchonUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        super.setUp()
        continueAfterFailure = true
        app = XCUIApplication()
        app.launch()

    }
    func testTabBarController() throws {
        // UI tests must launch the application that they test.
        app.launch()
        // passing throw the different view controllers of the tab bar
        app.tabBars.firstMatch.buttons.element(boundBy: 1).tap()
        app.tabBars.firstMatch.buttons.element(boundBy: 2).tap()
        app.tabBars.firstMatch.buttons.element(boundBy: 1).tap()
        app.tabBars.firstMatch.buttons.element(boundBy: 2).tap()
    }
    func testTranslateViewController() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        // search for translateTextfield
        XCTAssert(app.textFields["translateTextField"].exists, "test text field doesn't exist" )
        let tf = app.textFields["translateTextField"]
        tf.tap()    // must give text field keyboard focus!
        tf.typeText("Hola!")
        app.keyboards.buttons["Send"].tap()
            // send a translation and have a result
        XCTAssert( tf.exists, "tf exists" )   // text field still exists
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testConvertController() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.tabBars.firstMatch.buttons.element(boundBy: 1).tap()
        // search for convertviewcontroller
        // look for changetextfield
        XCTAssert(app.textFields["changeTextField"].exists, "test text field doesn't exist" )
        let tf = app.textFields["changeTextField"]
        tf.tap()    // must give text field keyboard focus!
        tf.typeText("35")
        app.buttons["conversionButton"].tap()
        XCTAssert( tf.exists, "tf exists" )   // text field still exists
    }
    func testWeatherController() throws {
        // UI tests must launch the application that they test.

        let app = XCUIApplication()
        app.launch()
        // look for citySearchtextfield
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
