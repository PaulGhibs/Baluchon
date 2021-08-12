//
//  Change.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 11/08/2021.
//

import Foundation

class Change {

    // MARK: - Properties
    enum Currency: String {
        case euro = "EUR"
        case dollarUS = "USD"
    }

    var date: Date
    var rates: [String : Float]

    init(date: Date, rates: [String : Float]) {
        self.date = date
        self.rates = rates

        ConversionJSON.lastUpdate = date
        ConversionJSON.lastRates = rates
    }

    // MARK: - Methods
    func convert(_ amount: String?, from sourceCurrency: Currency, to targetCurrency: Currency) -> String {

        guard let amountString = amount else {
            return ""
        }

        // Bug with the decimal separator on the pad
        guard let amountFloat = Float(amountString.replacingOccurrences(of: ",", with: ".")) else {
            return ""
        }

        if targetCurrency == .euro {
            guard let currencyRate = rates[sourceCurrency.rawValue] else {
                return ""
            }
            return String(format: "%.3f", amountFloat * 1 / currencyRate)
        } else {
            guard let currencyRate = rates[targetCurrency.rawValue] else {
                return ""
            }
            return String(format: "%.3f", amountFloat * currencyRate)
        }
    }

    // formats the date for display
    func displayDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "FR-fr")

        return dateFormatter.string(from: date)
    }
}


