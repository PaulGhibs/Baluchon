//
//  Extension.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 05/08/2021.
//

import Foundation
import UIKit


extension UIViewController {
//Show an alert to the user if there is no data coming back from network
    // method to display an alert
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style:.cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    // method to manage button and activity controller together
    func activityIndicator(activityIndicator: UIActivityIndicatorView, button: UIButton, showActivityIndicator: Bool){
        activityIndicator.isHidden = !showActivityIndicator
        button.isHidden = showActivityIndicator
    }
    
}
/// TRANSLATION VIEW CONTROLLER
extension TranslateViewController {
    
//// Parameters for translate language
//func setUpParamsAtLaunch(){
//    if defaults.object(forKey: ChooseLangController.topLangPickerKey) != nil{
//        setUserSavedParameters()
//    }
//    else {
//        setDefaultsParameters()
//    }
//}
//
//func setUserSavedParameters(){
//    topLabel.text! = defaults.string(forKey: ChooseLangController.topLanguageKey)!
//    botLabel.text! = defaults.string(forKey: ChooseLangController.bottomLanguageKey)!
//    topFlag.setImage(UIImage(named: defaults.string(forKey: ChooseLangController.topLangImageKey)!), for: .normal)
//    botFlag.setImage(UIImage(named: defaults.string(forKey: ChooseLangController.bottomLangImageKey)!), for: .normal)
//    params = ["source": defaults.string(forKey: ChooseLangController.topLangCodeKey)!, "target": defaults.string(forKey: ChooseLangController.bottomLangCodeKey)!]
//}
//
//func setDefaultsParameters(){
//    params = ["source": "fr", "target": "en"]
//    topFlag.setImage(#imageLiteral(resourceName: "france"), for: .normal)
//    botFlag.setImage(#imageLiteral(resourceName: "united-kingdom"), for: .normal)
//    topLabel.text! = "French"
//    botLabel.text! = "English"
//}
//}
//
////Delegate of the ChangeLanguage protocol for the users preferences
//extension TranslateViewController: chooseLanguague {
//    func userChooseNewLanguage(top: taLang, bottom: taLang) {
//        self.topFlag.setImage(top.flag, for: .normal)
//        self.botFlag.setImage(bottom.flag, for: .normal)
//        self.topLabel.text = top.language
//        self.botLabel.text = bottom.language
//        clearText()
//        params = ["source": top.code, "target": bottom.code]
//    }
//
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "changeCountry"{
//            let destinationVC = segue.destination as! ChooseLangController
//            destinationVC.delegate = self
//        }
//    }
//}
//
///// ChooseLang  VIEW CONTROLLER
//extension ChooseLangController: UIPickerViewDelegate, UIPickerViewDataSource {
//    // method to return the number's colum of the UIPickerView
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    // method to return the number of lines in the UIPickerView
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if (pickerView.tag == 1) {
//            return firstPickerOptions.count
//        } else {
//            return secondPickerOptions.count
//        }
//    }
//    // method to fill the UIPickerView with stored data
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if (pickerView.tag == 1) {
//            return firstPickerOptions[row].language
//        } else {
//            return secondPickerOptions[row].language
//        }
//    }
//    // method to set the UIButon of translate with stored data
//    func setPickerToUserSelect() {
//        firstLanguagePicker.selectRow(defaults.integer(forKey: ChooseLangController.topLangPickerKey), inComponent: 0, animated: true)
//        translatedLanguagePicker.selectRow(defaults.integer(forKey: ChooseLangController.bottomLangPickerKey), inComponent: 0, animated: true)
//    }
//
//}
//
//
///// CHANGE VIEW CONTROLLER
//
//
//
}
