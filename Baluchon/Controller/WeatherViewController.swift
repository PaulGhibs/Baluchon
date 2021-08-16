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
    var weatherManager = WeatherService()
    let locationManager = CLLocationManager()
    
    // MARK: Outlets
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var activityIndic: UIActivityIndicatorView!
    
 
