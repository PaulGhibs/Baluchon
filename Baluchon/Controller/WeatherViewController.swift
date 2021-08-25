//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 28/07/2021.
//

import Foundation
import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    // MARK: Properties
    let locationManager = CLLocationManager()
    // dependencies injection for testing purposes
    var weatherManager = WeatherService(weatherSession: URLSession(configuration: .default))
    // MARK: - Outlets
    // search button
    @IBOutlet weak var searchButton: UIButton!
    // position button
    @IBOutlet weak var positionButton: UIButton!
    // search bar text field
    @IBOutlet weak var searchBar: UITextField!
    // activity indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // city label of stackview
    @IBOutlet weak var cityLab: UILabel!
    // temps label of stackview
    @IBOutlet weak var tempLabel: UILabel!
    // icon imageview of stackview

    @IBOutlet weak var icon: UIImageView!
    // MARK: - Actions
    // search by coordinates
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        // CLLocationManagerDelegate with coreLocations
        locationManager.requestLocation()
    }
    // search city
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchBar.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // protocol location manager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        // delegate weather manager for updating weather and search locations
        weatherManager.delegate = self
        searchBar.delegate = self
        // hide temp citylabel and icon
        tempLabel.text = ""
        cityLab.text = ""
        icon.image = .none
    }
}


// MARK: - Textfield Delegate
extension WeatherViewController: UITextFieldDelegate {
    // MARK: Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Tap gesture recognizer for dismiss keyboard
        searchBar.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            // return type something if not city typed
            textField.placeholder = "Type something"
            return false
        }
    }
    // resign first reponder status 
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchBar.text {
            // Automatically return result with city when the user end type
            weatherManager.fetchWeather(cityName: city)
        }
        // Clear text if a city is found
        searchBar.text = ""
    }
    
    
}
// MARK: - WeatherManagerDelegate
extension WeatherViewController : WeatherManagerDelegate {
    // call protocol WeatherManagerDelegate if weather is trigger by citysearch
    // Privacy location usage in info.plist
    func didUpdateWeather(_ weatherManager: WeatherService, weather: WeatherModel) {
        // execution of activityindicator, tempLabel, icon, and city lab with the info parsed from weather services
        DispatchQueue.main.async {
            self.toggleActivityIndicator(self.activityIndicator, shown: false)
            self.tempLabel.text = "\(weather.temperatureString)° C"
            self.icon.image = UIImage(systemName: weather.conditionName)
            self.cityLab.text = weather.cityName
        }
    }
    
    
    func didFailWithError(error: Error) {
      // if failed to load data from weather service show an alert with weather request failure from errorsMessages.swift
        DispatchQueue.main.async {
            self.toggleActivityIndicator(self.activityIndicator, shown: false)
            self.presentVCAlert(with: titleAlert.failure.rawValue,
                                and: messageAlert.weatherRequest.rawValue)
        }
    }
}



//MARK: - CLLocationManagerDelegate
extension WeatherViewController : CLLocationManagerDelegate {
    // call protocol if weather is trigger by location
    // Privacy location usage in info.plist with ClllocationManager and didupdatelocations as parameters
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // user location is well activated in setting update
        if let location = locations.last {
            // call to locationManager for stop updating and capture the coordinates
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            // call to function of weatherManager for updating the weather by coordinates
            weatherManager.fetchWeatherByCoordinates(latitude: lat, longitude: lon)
            // print result
            print(lat, lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            // if location is not activated or not working show an error failure from errorsMessages.swift
            self.presentVCAlert(with: titleAlert.failure.rawValue,
                                and: messageAlert.weatherRequest.rawValue)
        }
    }
}
