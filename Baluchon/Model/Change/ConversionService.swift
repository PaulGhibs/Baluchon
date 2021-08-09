//
//  Conversion.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 01/08/2021.
//

import Foundation

class ConversionService {
    
    // MARK: - Properties
    let fixerAPIKey = Constants.valueAPIKey("apiExchange")
    // URLSession
    var conversionSession = URLSession(configuration: .default)
    //dataTask
    var task: URLSessionTask?
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.conversionSession = session
    }
    
    // MARK: - Methods
    func getSymbol(label: String) -> String {
        switch label {
        case "United States Dollar" : return "USD"
        case "Japanese Yen": return "JPY"
        case "Australian Dollar" : return "AUD"
        case "British Pound Sterling": return "GBP"
        case "Canadian Dollar" : return "CAD"
        case "Swiss Franc" : return "CHF"
        case "Euro" : return "EUR"
        default: break
        }
        return label
    }
    
    func getConversion(completionHandler: @escaping (ConversionJSON?, Error?) -> Void) {
        //API key
        guard let request = URL(string: "http://data.fixer.io/api/latest?access_key=\(fixerAPIKey)") else { return }
        task?.cancel()
        task = conversionSession.dataTask(with: request) {(data, response, err) in DispatchQueue.main.async {
            // response
            guard let response = response  as? HTTPURLResponse, response.statusCode == 200  else {
                completionHandler(nil, ErrorCases.wrongResponse(statusCode: (response as? HTTPURLResponse)?.statusCode))
                return
            }
            // data
            guard let data = data else {
                completionHandler(nil, ErrorCases.noData)
                return
            }
            // error
            guard err == nil else {
                completionHandler(nil, ErrorCases.noData)
                return
            }
            // check response Json
            do {
                let jsonResponse = try JSONDecoder().decode(ConversionJSON.self, from: data)
                completionHandler(jsonResponse, nil)
            } catch {
                completionHandler(nil, ErrorCases.errorDecode)
            }
            
        }
            
        }
        task?.resume()
    }
    
}

