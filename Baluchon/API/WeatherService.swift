//
//  Weather.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 01/08/2021.
//

import Foundation


class WeatherService {
    // MARK: - Properties

    static func getWeather(for city: String) -> URLRequest {
        let query = Weather.url + city

        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let stringURL = Weather.endpoint + encodedQuery

        let url = URL(string: stringURL)!
        var request = URLRequest(url: url)
        request.httpMethod = MethodHttp.get.rawValue

        return request
    }
    
    static func parse(_ data: Data, with decoder: JSONDecoder) -> Any {
        guard let json = try? decoder.decode(WeatherJSON.self, from: data) else {
            return (-1)
        }

        let resource = CityWeather(from: json)
        return resource
    }
    
}
