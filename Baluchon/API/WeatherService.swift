//
//  Weather.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 01/08/2021.
// swiftlint:disable all

import Foundation
import CoreLocation

// protocol for parsing data in function of location
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherService, weather: WeatherModel)
    func didFailWithError(error: Error)
}

// Weather service API 
struct WeatherService {
    // Singleton pattern
    static var shared = WeatherService()
    private init() {}
    // Attribute & init
    private var task: URLSessionDataTask?
    private var weatherSession = URLSession(configuration: .default)
    // dependencies injection for testing purposes
    init(weatherSession: URLSession) {
        self.weatherSession = weatherSession
    }
    var delegate: WeatherManagerDelegate?
    
    // Build a URL to access openweather API by city
    func fetchWeather(cityName: String) {
        let urlString = "\(OpenWeather.url)&q=\(cityName)"
        performRequest(with: urlString)
    }
    // Build a URL to access openweather API by location
    // need coreLocation to have the exact lat & lon
    func fetchWeatherByCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(OpenWeather.url)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    // request weather and update with protocol if there is an error
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            // default session for task with data response error protocol if failed
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    // parse result and return to the weatherModel
    // parse of Services protocol wasn't good and failed with location
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            // weather model struct with id temp and city name
            let id = decodedData.weather[0].id
            let temperature = decodedData.main.temp
            let cityName = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: cityName, temperature: temperature)
            // return weather as weather model from decoder with id city name and temperature
            return weather
        } catch {
            // do for decoding data and catch if there is an error call the protocol with didFailWithError
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

