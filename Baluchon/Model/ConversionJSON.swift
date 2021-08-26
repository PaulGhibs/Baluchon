//
//  ChangeJSON.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 04/08/2021.
// swiftlint:disable all

import Foundation

/* Managing data coming from Fixer api as codable
 fixer response is
 "rates":{"USD":1.167372,"JPY":128.164629,"EUR":1}
 */
// Target Conversion Rate
enum ConversionRates: String {
    case USD = "USD"
}

// Convert from Euro to US Dollar
struct ConversionJson: Decodable {
    let rates: [String: Double]
}

extension ConversionJson {
    // Convert a value according to a given rate
    static func convert(_ value: Double, with rate: Double) -> String {
        let convertedValue = (value / rate)
        // String rounded to 2 decimal places
        return String(format: "%.2f", convertedValue)
    }
}
