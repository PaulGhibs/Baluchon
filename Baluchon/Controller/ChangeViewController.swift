//
//  ViewController.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 28/07/2021.
//

import UIKit

class ChangeViewController: UIViewController, UITextFieldDelegate {
    
    //    MARK: - Properties
    var chooseCurrencyData: [String] = ["Australian Dollar 🇦🇺", "Canadian Dollar 🇨🇦", "Swiss Franc 🇨🇭", "Euro 🇪🇺", "British Pound Sterling 🏴󠁧󠁢󠁥󠁮󠁧󠁿", "Japanese Yen 🇯🇵", "United States Dollar 🇺🇸"]
    // instance of the conversionService class

    //    MARK: - Outlets

    @IBOutlet weak var firstCurrency: UIButton!
    @IBOutlet weak var secCurrency: UIButton!
    @IBOutlet weak var firstCurrencyChange: UITextField!
    @IBOutlet weak var secCurrencyChange: UITextField!
    @IBOutlet weak var chooseCurrency: UIPickerView!
    @IBOutlet weak var update: UIButton!
    @IBOutlet weak var activityIndic: UIActivityIndicatorView!
    
    
    //    MARK: - Actions
    @IBAction func currencyOne(_ sender: Any) {
        chooseCurrency.isHidden = false
        firstCurrency.isSelected = true
    }
    @IBAction func currencyTwo(_ sender: Any) {
        chooseCurrency.isHidden = false
        secCurrency.isSelected = true
    }

    @IBAction func change(_ sender: Any) {
        guard firstCurrency.title(for: .normal) != "First Currency", secCurrency.title(for: .normal) != "Second Currency" else {
         alert(title: "OK", message: "Choisissez une devise !")
            return
        }
        guard firstCurrencyChange.text != "", firstCurrencyChange.text != "." else {
         alert(title: "OK", message: "Entrez un montant !")
            return
        }
    }
    
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        firstCurrency.resignFirstResponder()
        secCurrency.resignFirstResponder()
    }
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndic.isHidden = true
        chooseCurrency.isHidden = true
       
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Methods
    // get rate from the call and convert
}
