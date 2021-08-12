//
//  APIRequests.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 12/08/2021.
//

import Foundation


class APIRequests {
    var request: URLRequest?
    private init() {}

    //network call for states to the vcs
    typealias Callback = (Bool, Any?) -> Void
    var resource: Any?
    
    static var shared = APIRequests()
    private var session = URLSession(configuration: .default)
    // dependcies injection for tests
    private var task: URLSessionDataTask?
    
    init(session: URLSession) {
        self.session = session
    }
}

extension APIRequests {
    // Perform a session dataTask with URLRequest to different APIs
    
    func makeRequest(API: Services, input: String = "", callback: @escaping Callback) {
        // Openweathermap not functional for now
        if API != .openweathermap { task?.cancel() }

       
        guard let request = getRequest(API: API) else {
        callback(false, nil)
            return
        }
        task = session.dataTask(with: request) { [weak self] (data, response, err) in
            DispatchQueue.main.async {
                guard let data = data, err == nil else {
                    callback(false, nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }

                let decoder = JSONDecoder()
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

extension APIRequests {
    func getRequest(API: Services, for input: String = "") -> URLRequest? {
        switch API {
        case .fixer:
            request = ConversionService.getConversion()
        case .translate:
            request = TranslatorService.getTranslation(for: input)
        case .openweathermap:
            request = WeatherService.getWeather(for: input)
    }
        return request

}
}
