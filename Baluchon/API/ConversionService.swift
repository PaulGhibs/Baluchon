//
//  Conversion.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 01/08/2021.
//

import Foundation
// Fixer API
struct ConversionService {
    //     Build a URL to access API
    static func getConversion() -> URLRequest {
        // url instance with parameters of structure fixer from services.swift
        let url = URL(string: Fixer.url)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = MethodHttp.get.rawValue
        return urlRequest
    }
}

extension ConversionService: ServiceProtocol {
    // parse data from json with serviceProtocol 
    static func parse(_ data: Data, with decoder: JSONDecoder) -> Any {
        guard let json = try? decoder.decode(ConversionJson.self, from: data) else {
            return -1
        }
        // and decode from ConversionJson Model 
        guard let resource = json.rates[ConversionRates.USD.rawValue] else {
            return -2
        }
        
        return resource
    }
    
    
    
}
