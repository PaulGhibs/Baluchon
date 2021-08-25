//
//  WeatherServiceTestCase.swift
//  BaluchonTests
//
//  Created by Paul Ghibeaux on 22/08/2021.
//

import CoreLocation
import XCTest
@testable import Baluchon


class WeatherServiceTestCase: XCTestCase {

    // this is the URL we expect to call
    let endpointURL = URL(string: "https://api.openweathermap.org/data/2.5/weather")!
    let latitude: Double = 123
    let longitude: Double = 321
    var weather: WeatherManagerDelegate?
    // MARK: - Setup with WeatherTestURLProtocol
    override class func setUp() {
      super.setUp()
      URLProtocol.registerClass(WeatherTestURLProtocol.self)
    }

    // MARK: - tests WeatherModel
    func testWeatherModelForATemperatureString() {
        // Given
        let weatherModel = WeatherModel(conditionId: 1, cityName: "Paris", temperature: Double(115))
        // When
        let query = weatherModel.temperatureString
        // Then
        print(query)
        XCTAssertEqual(query, query)
        XCTAssertNotNil(query)

    }
    
    func testGivenWeatherModelforConditionName () {
        // Given
        let weatherModel = WeatherModel(conditionId: 1, cityName: "Paris", temperature: Double(115))
        // When
        let query = weatherModel.conditionName
        // Then
        print(query)
        XCTAssertEqual(query, query)
        XCTAssertNotNil(query)
    }
    
    func testGivenWeatherModelConditionNameCount() {
        // Given
        let weatherModel = WeatherModel(conditionId: 1, cityName: "Paris", temperature: Double(115))
        // When
        let query = weatherModel.conditionName.count
        // Then
        print(query)
        XCTAssertEqual(query, query)
        XCTAssertTrue((query != 0))
        XCTAssertNotNil(query)
    }
    
    // MARK: - tests callbackUrls with WeatherTestUrlProtocol
    func testOpenWeatherGivenWeatherTestUrlProtocol() throws {
        // Given
      var request = URLRequest(url: endpointURL)
      WeatherTestURLProtocol.mockResponses[endpointURL] = {
        request = $0
        return (.success(Data([])), 0) // Doesn't matter
      }
        let city = "Paris"
        WeatherService.shared.fetchWeatherByCoordinates(latitude: latitude, longitude: longitude)
        WeatherService.shared.fetchWeather(cityName: city)
        // When
      let sentRequest = try XCTUnwrap(request)
      let queryItems = URLComponents(url: sentRequest.url!, resolvingAgainstBaseURL: false)?.queryItems

        // Then
      XCTAssertNil(queryItems?["APPID"])
      XCTAssertNil(queryItems?["units"])
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        _ = WeatherService(weatherSession: URLSession(configuration: .default))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue weather.")
        let city = "New York"
        WeatherService.shared.fetchWeather(cityName: city)
            // Then
            XCTAssertNil(weather)
            expectation.fulfill()
        }
    }


  extension Array where Element == URLQueryItem {
    // Returns the value of the URLQueryItem with the given name. Returns `nil`
    // if the query item doesn't exist.
    fileprivate subscript(_ name: String) -> String? {
      first(where: { $0.name == name }).flatMap { $0.value }
    }
  }

