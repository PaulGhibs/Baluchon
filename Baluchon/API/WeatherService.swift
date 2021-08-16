//
//  Weather.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 01/08/2021.
//

import Foundation


struct WeatherService {
    
    
    // MARK: - Properties
    static func getWeather(for city: String) -> URLRequest {
        let url = Weather.url
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = MethodHttp.get.rawValue

        return urlRequest

    }
}

extension WeatherService: ServiceProtocol {
    static func parse(_ data: Data, with decoder: JSONDecoder) -> Any {
        guard let decodedData = try? decoder.decode(WeatherJSON.self, from: data) else {
            return 1
        }
        let id = decodedData.weather[0].id
        let temperature = decodedData.main.temp
        let cityName = decodedData.name
        let weather = WeatherJSON(conditionId: id, cityName: cityName, temperature: temperature)
        
        return weather
        
    }
    
}
