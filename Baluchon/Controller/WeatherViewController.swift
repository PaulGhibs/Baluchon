//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 28/07/2021.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    // MARK: Properties
    let locationManager = CLLocationManager()
    var weatherManager = WeatherService()

    // MARK: Outlets
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var positionButton: UIButton!
    @IBOutlet weak var waitingLabel: UILabel!
    
    @IBOutlet weak var cityLab: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    // MARK: Actions

   
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    

    // MARK: - Properties
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchBar.delegate = self
        
        tempLabel.text = ""
        cityLab.text = ""
        icon.image = .none
    }
    
    
}


// MARK: Methods


// MARK: UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchBar.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchBar.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchBar.text = ""
    }
    
    
}
// MARK: WeatherManagerDelegate
extension WeatherViewController : WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherService, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.waitingLabel.isHidden = true
            self.tempLabel.text = "\(weather.temperatureString)° C"
            self.icon.image = UIImage(systemName: weather.conditionName)
            self.cityLab.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "We're sorry, but something went wrong. Please try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    
}



//MARK: - CLLocationManagerDelegate
extension WeatherViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager.fetchWeatherByCoordinates(latitude: lat, longitude: lon)
            print(lat, lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.presentVCAlert(with: titleAlert.failure.rawValue,
                                and: messageAlert.weatherRequest.rawValue)
        }
    }
}
