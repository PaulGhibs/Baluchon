//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 28/07/2021.
//

import Foundation
import UIKit

class TranslateViewController: UIViewController {
    
    //    MARK: - Outlets

    @IBOutlet weak var traduireLabel: UILabel!
    
    @IBOutlet weak var translateTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //    MARK: - Actions
    @IBAction func dismiss(_ sender: UITapGestureRecognizer) {
        translateTextField.resignFirstResponder()
        translateTextField.text = ""
    }
}
    
// MARK: - Textfield Delegate

// Set up UITextFieldDelegate
extension TranslateViewController: UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.translateTextField.delegate = self
        toggleActivityIndicator(activityIndicator, shown: false)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        traduireLabel.isEnabled = false
    }
}

// MARK: - Request

extension TranslateViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        translateTextField.becomeFirstResponder()
        guard let text = translateTextField.text else { return false }
        checkInputValidity(input: text)
        return true
    }


    private func checkInputValidity(input: String) {
        if translateTextField.text == "" {
            presentVCAlert(with: titleAlert.translateInputValidity.rawValue,
                           and: messageAlert.translateInputValidity.rawValue)
        } else {
            requestTranslation(for: input)
        }
    }

   
    private func requestTranslation(for input: String) {
        self.toggleActivityIndicator(activityIndicator,shown: true)

        APIService.shared.query(API: .translate, input: input) { (success, resource) in
            if success, let translatedText = resource as? String {
                self.toggleActivityIndicator(self.activityIndicator, shown: false)
                self.translateTextField.text = translatedText
            } else {
                self.toggleActivityIndicator(self.activityIndicator, shown: false)
                self.presentVCAlert(with: titleAlert.failure.rawValue,
                                    and: messageAlert.translateRequest.rawValue)
            }
        }
    }
}
