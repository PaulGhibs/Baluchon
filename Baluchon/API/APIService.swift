//
//  APIRequests.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 12/08/2021.
//

import Foundation

// Perform API requests
class APIService {
    // A closure to provide the state of a network call to the ViewControllers
    typealias Callback = (Bool, Any?) -> Void
    var request: URLRequest?
    //Decoded data from an API
    var resource: Any?

    static var shared = APIService()
    private init() {}

    private var task: URLSessionDataTask?

    // for testing purpose
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }
}

extension APIService {
   
    func query(API: Services, input: String = "", callback: @escaping Callback) {
        guard let request = getRequest(API: API, for: input) else {
        callback(false, nil)
            return
        }

        task = session.dataTask(with: request) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }

                let decoder = JSONDecoder()
               // guard
                
            
                switch API {
                case .fixer:
                    if ConversionService.parse(data, with: decoder) as? Int == -1 ||
                        ConversionService.parse(data, with: decoder) as? Int == -2 {
                        callback(false, nil)
                        return
                    }
                    self?.resource = ConversionService.parse(data, with: decoder)

                case .translate:
                    if TranslatorService.parse(data, with: decoder) as? Int == -1 {
                        callback(false, nil)
                        return
                    }
                    self?.resource = TranslatorService.parse(data, with: decoder)
                    
                case .openweathermap:
                    if WeatherService.parse(data, with: decoder) as? Int == -1 {
                        callback(false, nil)
                        return
                    }
                    self?.resource = WeatherService.parse(data, with: decoder)
                }

                callback(true, self?.resource)
            }
        }
        task?.resume()
    }
}

extension APIService {
    
    private func getRequest(API: Services, for input: String = "") -> URLRequest? {
        switch API {
        case .fixer:
            request = ConversionService.getConversion()
        case .translate:
            request = TranslatorService.createRequest(for: input)
        case .openweathermap:
            request = WeatherService.getWeather(for: input)}
        return request
    }
}
