//
//  Weather.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 01/08/2021.
//

import Foundation
import CoreLocation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherService, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherService {
    var delegate: WeatherManagerDelegate?

    func fetchWeather(cityName: String) {
        let urlString = "\(openWeather.url)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeatherByCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(openWeather.url)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temperature = decodedData.main.temp
            let cityName = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: cityName, temperature: temperature)
            
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

}

    
    
    

