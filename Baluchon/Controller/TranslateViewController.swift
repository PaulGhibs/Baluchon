//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 28/07/2021.
//

import Foundation
import UIKit

class TranslateViewController: UIViewController {
    // MARK: - Outlets
    //  Traduire label
    @IBOutlet weak var traduireLabel: UILabel!
    //  Translate textfield
    @IBOutlet weak var translateTextField: UITextField!
    //  activity indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: - Actions
    @IBAction func dismiss(_ sender: UITapGestureRecognizer) {
        // UiPangesture recognizer for dismiss keyboard of all the screen when touching
        translateTextField.resignFirstResponder()
        translateTextField.text = ""
    }
}

// MARK: - Textfield Delegate

// Set up UITextFieldDelegate
extension TranslateViewController: UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Automatically return result with translation
        self.translateTextField.delegate = self
        // hide activity indicator when nothing is typed
        toggleActivityIndicator(activityIndicator, shown: false)
    }
    // Automatically return when typing is done
    func textFieldDidBeginEditing(_ textField: UITextField) {
        traduireLabel.isEnabled = false
    }
}

// MARK: - Request

extension TranslateViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // translate text field become first reponder
        translateTextField.becomeFirstResponder()
        // Translated text return or return false
        guard let text = translateTextField.text else { return false }
        // checking validity before translate
        checkInputValidity(input: text)
        return true
    }
    // autodetection languages of the textfield if nothing found present alert from Uialert with errormessagesAlert
    func checkInputValidity(input: String) {
        if translateTextField.text == "" {
            presentVCAlert(with: TitleAlert.translateInputValidity.rawValue,
                           and: MessageAlert.translateInputValidity.rawValue)
        } else {
            // if a language is found request the translation
            requestTranslation(for: input)
        }
    }
    func requestTranslation(for input: String) {
        // show the activity indicator during the request
        self.toggleActivityIndicator(activityIndicator, shown: true)
        // call API service with translate parameters from struct in Services
        APIService.shared.query(API: .translate, input: input) { (success, resource) in
            // if success present the translateTextfield with the translated text
            if success, let translatedText = resource as? String {
                self.toggleActivityIndicator(self.activityIndicator, shown: false)
                self.translateTextField.text = translatedText
            } else {
                // if error show an alert message with errormessages alert
                // and stop showing the activity indicator
                self.toggleActivityIndicator(self.activityIndicator, shown: false)
                self.presentVCAlert(with: TitleAlert.failure.rawValue,
                                    and: MessageAlert.translateRequest.rawValue)
            }
        }
    }
}
