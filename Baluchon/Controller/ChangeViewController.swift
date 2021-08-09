//
//  ViewController.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 28/07/2021.
//

import UIKit

class ChangeViewController: UIViewController {
    
    //    MARK: - Properties
    var chooseCurrencyData: [String] = ["Australian Dollar 🇦🇺", "Canadian Dollar 🇨🇦", "Swiss Franc 🇨🇭", "Euro 🇪🇺", "British Pound Sterling 🏴󠁧󠁢󠁥󠁮󠁧󠁿", "Japanese Yen 🇯🇵", "United States Dollar 🇺🇸"]
    // instance of the conversionService class
    let change = ConversionService()

    //    MARK: - Outlets

    @IBOutlet weak var firstCurrency: UIButton!
    @IBOutlet weak var secCurrency: UIButton!
    @IBOutlet weak var chooseCurrency: UIPickerView!
    @IBOutlet weak var update: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


