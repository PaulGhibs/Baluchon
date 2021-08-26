//
//  Services.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 12/08/2021.
// swiftlint:disable all

import Foundation
import CoreLocation

// list HTTPMethods
enum MethodHttp: String {
    case post = "POST", get = "GET"
}

// services used by Baluchon
enum Services {
    case fixer, translate
}

// Hold access to ressources by Services
// FIXER
struct Fixer {
    static private let endpoint = "http://data.fixer.io/api/latest"
    // API KEYS setup in constants.swift
    static private let accessKey = "?access_key=\(Constants.valueAPIKey("apiExchange"))"
    static private let parameters = "&sybols=USD"
    // return fixer url conversion + api key + parameters
    static var url: String { return Fixer.endpoint + Fixer.accessKey + Fixer.parameters }
}
// TRANSLATE
struct Translate {
    static private let endpoint = "https://translation.googleapis.com/language/translate/v2"
    static private let accessKey = "?key=\(Constants.valueAPIKey("apiTranslate"))"
    static private let parameters = "&source=fr&target=en&format=text&q="
    // return Google Translation service location
    static var url: String {
        return Translate.endpoint + Translate.accessKey + Translate.parameters
    }
}
// openWeather
struct OpenWeather {
    static let endpoint = "https://api.openweathermap.org/data/2.5/weather?"
    static let accessKey = "appid=\(Constants.valueAPIKey("apiWeather"))"
    static let parameters = "&units=metric"
    static var url: String { return OpenWeather.endpoint + OpenWeather.accessKey + OpenWeather.parameters }
}

// Parse data using a `JSONDecoder`
protocol ServiceProtocol {
    // Decode an API response and return the requested resource
    associatedtype T
    static func parse(_ data: Data, with decoder: JSONDecoder) -> T
}
