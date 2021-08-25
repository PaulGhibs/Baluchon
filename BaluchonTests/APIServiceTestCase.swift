//
//  APIServiceTestCase.swift
//  BaluchonTests
//
//  Created by Paul Ghibeaux on 21/08/2021.
//

import XCTest
import Foundation
@testable import Baluchon

class APIServiceTestCase: XCTestCase {
    // MARK: - Properties
    let services : [Services] = [.fixer, .translate]
    // MARK: - Test query handler failure
    override func tearDown() {
        TestURLProtocol.loadingHandler = nil
    }
    
    // test query completion handler failure for each webservice
    func testQueryCompletionHandlerFailure() {
        for webservice in services {
            var input: String
            switch webservice {
            case .fixer: input = ""
            case .translate: input = "Salut World!"
            }
            
            testQueryShouldPostFailedCallbackIfError(webservice, input)
            testQueryShouldPostFailedCallbackIfNoData(webservice, input)
            testQueryShouldPostFailedCallbackIfIncorrectResponse(webservice, input)
        }
    }
    
    func testQueryShouldPostFailedCallbackIfError(_ webservice: Services, _ input: String) {
        // Given
        let response = FakeResponseData.responseKO
        let error = FakeResponseData.error
        
        TestURLProtocol.loadingHandler = { request in
            return ( nil, response,  error)
        }
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        let apiService = APIService(
            session: URLSession(configuration: configuration))
 
        // When
        
        apiService.query(API: services[0], input: input) { (success, resource) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(resource)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testQueryShouldPostFailedCallbackIfNoData(_ webservice: Services, _ input: String) {
        // Given
        let response = FakeResponseData.responseKO
        let error = FakeResponseData.error
        
        TestURLProtocol.loadingHandler = { request in
            return ( nil, response,  error)
        }
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        let apiService = APIService(
            session: URLSession(configuration: configuration))
        
        // When
        apiService.query(API: services[0], input: input) { (success, resource) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(resource)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testQueryShouldPostFailedCallbackIfIncorrectResponse(_ webservice: Services, _ input: String) {
        // Given
        let response = FakeResponseData.responseKO
        let error = FakeResponseData.error
        
        TestURLProtocol.loadingHandler = { request in
            return ( nil, response,  error)
        }
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        let apiService = APIService(
            session: URLSession(configuration: configuration))
        
        // When
        apiService.query(API: services[0], input: input) { (success, resource) in

            // Then
            XCTAssertFalse(success)
            XCTAssertNil(resource)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Test Fixer callback
    
    func testQueryConvertShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let response = FakeResponseData.responseKO
        let error = FakeResponseData.error
        
        TestURLProtocol.loadingHandler = { request in
            return ( nil, response,  error)
        }
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        let apiService = APIService(
            session: URLSession(configuration: configuration))
        
        // When
        apiService.query(API: services[0]) { (success, resource) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(resource)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testQueryConvertShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        //given
        let response = FakeResponseData.responseOK
        let jsonData = FakeResponseData.convertCorrectData
        
        TestURLProtocol.loadingHandler = { request in
            return ( jsonData, response,  nil)
        }
        
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        let apiService = APIService(
            session: URLSession(configuration: configuration))
        
        // When
        apiService.query(API: services[0]) { (success, resource) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(resource)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Test Google callback

    func testQueryTranslateShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let response = FakeResponseData.responseKO
        let error = FakeResponseData.error
        
        TestURLProtocol.loadingHandler = { request in
            return ( nil, response,  error)
        }
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        let translateService = APIService(
            session: URLSession(configuration: configuration))
        
        // When
        translateService.query(API: services[1], input: "Hello, World!") { (success, resource) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(resource)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testQueryTranslateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        
        //given
        let response = FakeResponseData.responseOK
        let jsonData = FakeResponseData.translateCorrectData
        
        TestURLProtocol.loadingHandler = { request in
            return ( jsonData, response,  nil)
        }
        
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        let client = APIService(
            session: URLSession(configuration: configuration))
        
        client.query(API: services[1], input: "Hello, World!") { success, translate in
            XCTAssertTrue(success)
            XCTAssertNotNil(translate)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
        
    }
    
    // MARK: - Test openWeather callback

    func testRequestShouldPostFailedCallbackIfIncorrectData() {
        
        let response = FakeResponseData.responseOK
        let jsonData = FakeResponseData.weatherCorrectData
        
        TestURLProtocol.loadingHandler = { request in
            return ( jsonData, response,  nil)
        }
        
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        // Given
        let client = WeatherService(
            weatherSession: URLSession(configuration: configuration))
        // When
        client.performRequest(with: "Paris")
        // Then
        XCTAssertNotNil(jsonData)
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testRequestShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let response = FakeResponseData.responseOK
        let jsonData = FakeResponseData.weatherCorrectData
        TestURLProtocol.loadingHandler = { request in
            return ( jsonData, response,  nil)
        }
        
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        
        let client = WeatherService(
            weatherSession: URLSession(configuration: configuration))
        
        let city = "New York"
        // When
        client.performRequest(with: "New York")
        let result = client.parseJSON(jsonData!)
        print(result!)
        
        
        print(jsonData!)
        
        // Then
        XCTAssertNotNil(city)
        expectation.fulfill()
        
    }
    
    
    func testTranslationShouldReturnTranslatorModel() {
        // Given
        let translatedtext = [TranslatorJson.Translations.TranslatedText]()
        let translatedTarget = TranslatorJson.Translations(translations: translatedtext)
        // When
        let condition = TranslatorJson.init(data: translatedTarget )
        // Then
        XCTAssertNotNil(condition)

}
}






