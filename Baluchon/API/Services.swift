//
//  Services.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 12/08/2021.
//

import Foundation


// list HTPPMethods
enum MethodHttp: String {
    case post = "POST", get = "GET"
}
enum Services {
    case fixer, translate, openweathermap
}

// Hold access to ressources by Services
// FIXER
struct Fixer {
    static private let endpoint = "http://data.fixer.io/api/latest"
    static private let accessKey = "?access_key=\(Constants.valueAPIKey("apiExchange"))"
    static private let parameters = "&sybols=USD"
    static var url: String { return Fixer.endpoint + Fixer.accessKey + Fixer.parameters }
}
// TRANSLATE

struct Translate {
    static private let endpoint = "https://translation.googleapis.com/language/translate/v2"
    static private let accessKey = "?key=\(Constants.valueAPIKey("apiTranslate"))"
    static private let parameters = "&sybols=USD"
    static var url: String {
        return Translate.endpoint + Translate.accessKey + Translate.parameters
    }
    
}
// Weather
struct Weather {
    static let endpoint = "https://api.openweathermap.org/data/2.5/weather?"
    static let accessKey = "?key=\(Constants.valueAPIKey("apiWeather"))"
    static let parameters = ""
    static var url: String {
        return Weather.endpoint + Weather.accessKey + Weather.parameters
    }
    
}


// Parse data using a `JSONDecoder`
protocol ServiceProtocol {
    static func parse(_ data: Data, with decoder: JSONDecoder) -> Any
}

