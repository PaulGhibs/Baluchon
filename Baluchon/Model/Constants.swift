//
//  File.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 05/08/2021.
//

import Foundation


struct Constants {
    static func valueAPIKey(_ nameKey: String) -> String {
    //  path to ApiKeys.plist
    let path = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
    // dictionnary for key
    let plist = NSDictionary(contentsOfFile: path!)
    let value: String = plist?.object(forKey: nameKey) as! String
    return value
    }
}

class recurences {
    private struct Keys {
        static let changeUpdate = "changeUpdate"
        static let changeRates = "changeRates"
    }
}

// enumeration to manage errors
enum ErrorCases: Swift.Error {
    case noData
    case wrongResponse(statusCode: Int?)
    case failure
    case errorDecode
}


