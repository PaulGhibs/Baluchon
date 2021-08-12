//
//  Conversion.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 01/08/2021.
//

import Foundation

class ConversionService {

//     Build a URL to access Fixer API
    static func getConversion() -> URLRequest {
        let url = URL(string: Fixer.url)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = MethodHttp.get.rawValue

        return urlRequest
    }
    
    // parse data from json
    static func parse(_ data: Data, with decoder: JSONDecoder) -> Any {
        guard let json = try? decoder.decode(ConversionJSON.self, from: data) else {
            return -1
        }

        guard let resource = json.rates[Change.Currency.dollarUS.rawValue] else {
            return -2
        }

        return resource
    }
}


