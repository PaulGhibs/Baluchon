//
//  ChangeJSON.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 04/08/2021.
//

import Foundation

struct ConversionJSON: Decodable {
    enum CodingKeys: String, CodingKey {
        case rates = "rates"
        case dateString = "date"
    }

    var rates: [String : Float]
    private var dateString: String

    // convert the string in json into date
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-M-d"

        guard let dateFormatted = dateFormatter.date(from: dateString) else {
            fatalError()
        }

        return dateFormatted
}
    
    struct Keys {
        static let changeLastUpdate = "changeLastUpdate"
        static let changeLastRates = "changeLastRates"
        static let selectedCities = "selectedCities"
    }

    // MARK: - Change
    static var lastUpdate: Date? {
        get {
            return UserDefaults.standard.object(forKey: Keys.changeLastUpdate) as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.changeLastUpdate)
        }
    }

    static var lastRates: [String : Float]? {
        get {
            return UserDefaults.standard.object(forKey: Keys.changeLastRates) as? [String : Float]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.changeLastRates)
        }
    }

    // Compare the last update with the current day
    static var isUpdateNeeded: Bool {
        if let lastUpdate = lastUpdate {
            return !Calendar.current.isDate(Date(), equalTo: lastUpdate, toGranularity: .day)
        }
        return true
    }


}
