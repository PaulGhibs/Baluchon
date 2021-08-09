//
//  ChangeJSON.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 04/08/2021.
//

import Foundation

struct ConversionJSON: Decodable {
    
    let base: String
    let rates: [String: Double]
    
}

