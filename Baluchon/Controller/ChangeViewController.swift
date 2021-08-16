//
//  ViewController.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 28/07/2021.
//

import UIKit

class ChangeViewController: UIViewController {
    
    //    MARK: - Outlets
    @IBOutlet weak var instructLabel: UILabel!
    // user input text.
    @IBOutlet weak var convertTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // currency icon.
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var currencyLabel: UILabel!
    
    //    MARK: - Actions
    @IBAction func tappedConvertButton(_ sender: UIButton) {
        launchRequest()

    }
    @IBAction func dismiss(_ sender: UIGestureRecognizer) {
        convertTextField.resignFirstResponder()
        instructLabel.isEnabled = true
        currencyLabel.isEnabled = false
        convertButton.isHidden = true
    }
}

    // MARK: - Set up delegate

extension ChangeViewController: UITextFieldDelegate {
        override func viewDidLoad() {
            super.viewDidLoad()
            convertTextField.delegate = self

        }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(false)
            toggleActivityIndicator(activityIndicator, shown: false)
            currencyLabel.isEnabled = false
            currencyLabel.text = "€"

        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            currencyLabel.text = "€"
            instructLabel.isEnabled = false
            currencyLabel.isEnabled = true
            convertButton.isHidden = false
        }
    }

    // MARK: - Clear text field
    extension ChangeViewController {
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(false)
            convertTextField.text = ""
        }
        
    }

    // MARK: - Request service

    extension ChangeViewController {
        // Launch the request process (enable keyboard; call checkInputValidity() update the state of UI objects)
        private func launchRequest() {
            convertTextField.becomeFirstResponder()

            guard let amount = convertTextField.text else { return }
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

            APIService.shared.query(API: .fixer) { (success, resource) in
                self.toggleActivityIndicator(self.activityIndicator, shown: false)

                if success, let rate = resource as? Double {
                    self.updateDisplay(with: amount, and: rate)
                } else {
                    self.presentVCAlert(with: titleAlert.failure.rawValue,
                                        and: messageAlert.convertRequest.rawValue)
                }
            }
        }

        //  Update display with a requested currency conversion
        private func updateDisplay(with amount: Double, and rate: Double) {
            convertTextField.text = ConversionJson.convert(amount, with: rate)
            currencyLabel.text = "$"
        }
    }




