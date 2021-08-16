//
//  WeatherJSON.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 01/08/2021.
//

import Foundation


enum Icon: String {
    case tornade = "tornade", orage = "orage", averseNeige = "averseNeige",
    pluie = "pluie", averse = "averse", neige = "neige",
    brouillard = "brouillard", ventFort = "ventFort",
    couvert = "couvert", nuageuxNuit = "nuageuxNuit",
    nuageuxJour = "nuageuxJour", nuitClaire = "nuitClaire",
    jourClair = "jourClair", orageux = "orageux", quetionMark = "?"
}

struct WeatherJSON: Decodable {
    let query: Query

    struct Query: Decodable {
        let results: Channel

        struct Channel: Decodable {
            let channel: Location

            struct Location: Decodable {
                let location: City
                let item: Item

                struct City: Decodable {
                    let city: String
                }

                struct Item: Decodable {
                    let condition: Condition

                    struct Condition: Decodable {
                        let code: String
                        let temp: String
                    }
                }
            }
        }
    }
}

// MARK: - Model
// Define the CityWeather model data structure

struct CityWeather{
    var city: String
    
    // CityWeather condition code
  
    var code: String
    // Temperature in °C
    var temp: String
}

extension CityWeather {
    init(from service: WeatherJSON) {
        city = service.query.results.channel.location.city
        code = service.query.results.channel.item.condition.code
        temp = service.query.results.channel.item.condition.temp
    }
}

extension CityWeather {
   
}


/// List `cities` dictionary keys
enum DictionaryKeys {
    case newYork
    case currentLocation
}

/// Define places to query wheather conditions
struct Places {
    static var cities: [DictionaryKeys: Any] = [DictionaryKeys.newYork: "New York"]

}

extension Places {
    static func addCurrentLocation(_ coordinates: (Double, Double)) {
        Places.cities[DictionaryKeys.currentLocation] = coordinates
    }
}
