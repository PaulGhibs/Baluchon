//
//  WeatherJSON.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 01/08/2021.
//

import Foundation
/* Managing data coming from Fixer api as codable openweather response is
 "weather": [
 {
 "id": 701,
 "main": "Mist",
 "description": "mist",
 "icon": "50n"
 }
 ],
 "base": "stations",
 "main": {
 "temp": 23.43,
 "feels_like": 24.26,
 "temp_min": 21.64,
 "temp_max": 24.43,
 "pressure": 1010,
 "humidity": 93
 }
 */

// struct weatherData as codable for name, main struct and a tab of weather struct
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

// struct main as codable for temps
struct Main: Codable {
    let temp: Double
}

// struct Weather as codable for description and int for id
struct Weather: Codable {
    let description: String
    let id: Int
}

//  Define the weather model data structure
struct WeatherModel {
    let conditionId: Int
    
    let cityName: String
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    // switch for return an icon from sfSymbols in function of the temp
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}

