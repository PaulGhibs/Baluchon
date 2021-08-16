//
//  ChangeJSON.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 04/08/2021.
//

import Foundation

enum ConversionRates: String {
    case USD = "USD"
}

/// Convert from Euro to US Dollar
struct ConversionJson: Decodable {
    let rates: [String: Double]
}

extension ConversionJson {
    //Convert a value according to a given rate
    static func convert(_ value: Double, with rate: Double) -> String {
        let convertedValue = (value / rate)

        return String(format: "%.2f", convertedValue)
    }
}


//currency tab
let rates = [
        "USD", "AUD", "EUR", "JPY", "GBP", "AUD", "CAD"
]
