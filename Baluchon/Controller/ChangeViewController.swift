//
//  ViewController.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 28/07/2021.
//

import UIKit

class ChangeViewController: UIViewController {
    
    //    MARK: - Outlets
    // instruct label
    @IBOutlet weak var instructLabel: UILabel!
    // user input text.
    @IBOutlet weak var convertTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // currency icon.
    
    @IBOutlet weak var currencyLabel: UILabel!
    // convert button
    @IBOutlet weak var convertButton: UIButton!
    //    MARK: - Actions
    @IBAction func tappedConvertButton(_ sender: UIButton) {
        // request conversion
        launchRequest()
    }
    
    @IBAction func dismiss(_ sender: UIGestureRecognizer) {
        // resign first reponder with pan gesture recognizer
        convertTextField.resignFirstResponder()
        // instruct label shown
        instructLabel.isEnabled = true
        // currency label hidden
        currencyLabel.isEnabled = false
        // convert button hidden
        convertButton.isHidden = true
    }
}

// MARK: - Set up delegate

extension ChangeViewController: UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // delegate text field for automatic return
        convertTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        // activity indicator hidden when user is typing
        toggleActivityIndicator(activityIndicator, shown: false)
        currencyLabel.isEnabled = false
        currencyLabel.text = "€"
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currencyLabel.text = "€"
        // convert button, currencyLabel, and instruct label hidden when typing
        instructLabel.isEnabled = false
        currencyLabel.isEnabled = true
        convertButton.isHidden = false
    }
}

// MARK: - Clear text field
extension ChangeViewController {
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        // clear text field for retry conversion
        convertTextField.text = ""
    }
    
}

// MARK: - Request service

extension ChangeViewController {
    // Launch the request process (;
    private func launchRequest() {
        // enable keyboard
        convertTextField.becomeFirstResponder()
        
        guard let amount = convertTextField.text else { return }
        // call checkInputValidity()
        checkInputValidity(input: amount)
        convertTextField.resignFirstResponder()
        instructLabel.isEnabled = true
        convertButton.isHidden = true
    }
    
    // The method will replace a comma by a point to adress the european numeric keypad.
    private func checkInputValidity(input: String) {
        // change comma to point for european numeric keypads
        if let number = Double(input.replacingOccurrences(of: ",", with: ".")) {
            requestConversion(for: number)
        } else {
            presentVCAlert(with: titleAlert.convertInputValidity.rawValue,
                           and: messageAlert.convertInputValidity.rawValue)
            convertTextField.text = ""
        }
    }
    
    //method to display a converted currency
    private func requestConversion(for amount: Double) {
        toggleActivityIndicator(activityIndicator,shown: true)
        // call to api service.shared query with fixer structure as service parameters
        APIService.shared.query(API: .fixer) { (success, resource) in
            self.toggleActivityIndicator(self.activityIndicator, shown: false)
            // if success update display with result
            if success, let rate = resource as? Double {
                self.updateDisplay(with: amount, and: rate)
            } else {
                // if error update display with error from ErrorMessagesAlert and Uialert
                
                self.presentVCAlert(with: titleAlert.failure.rawValue,
                                    and: messageAlert.convertRequest.rawValue)
            }
        }
    }
    
    //  Update display with a requested currency conversion
    private func updateDisplay(with amount: Double, and rate: Double) {
        // refresh the state of UI objects
        convertTextField.text = ConversionJson.convert(amount, with: rate)
        currencyLabel.text = "$"
    }
}




