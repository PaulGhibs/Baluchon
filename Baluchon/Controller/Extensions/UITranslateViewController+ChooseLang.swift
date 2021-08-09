//
//  Extension.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 05/08/2021.
//

import Foundation
import UIKit



/// TRANSLATION VIEW CONTROLLER
extension TranslateViewController {

//Show an alert to the user if there is no data coming back from network
func presentAlert(){
    let alertVC = UIAlertController(title: "Error", message: "Error with getting the data", preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
    present(alertVC, animated: true, completion: nil)
}

    
// Parameters for translate language
func setUpParamsAtLaunch(){
    if defaults.object(forKey: ChooseLangController.topLangPickerKey) != nil{
        setUserSavedParameters()
    }
    else {
        setDefaultsParameters()
    }
}

func setUserSavedParameters(){
    topLabel.text! = defaults.string(forKey: ChooseLangController.topLanguageKey)!
    botLabel.text! = defaults.string(forKey: ChooseLangController.bottomLanguageKey)!
    topFlag.setImage(UIImage(named: defaults.string(forKey: ChooseLangController.topLangImageKey)!), for: .normal)
    botFlag.setImage(UIImage(named: defaults.string(forKey: ChooseLangController.bottomLangImageKey)!), for: .normal)
    params = ["source": defaults.string(forKey: ChooseLangController.topLangCodeKey)!, "target": defaults.string(forKey: ChooseLangController.bottomLangCodeKey)!]
}

func setDefaultsParameters(){
    params = ["source": "fr", "target": "en"]
    topFlag.setImage(#imageLiteral(resourceName: "france"), for: .normal)
    botFlag.setImage(#imageLiteral(resourceName: "united-kingdom"), for: .normal)
    topLabel.text! = "French"
    botLabel.text! = "English"
}
}


//Delegate of the ChangeLanguage protocol for the users preferences
extension TranslateViewController: chooseLanguague {
    func userChooseNewLanguage(top: taLang, bottom: taLang) {
        self.topFlag.setImage(top.flag, for: .normal)
        self.botFlag.setImage(bottom.flag, for: .normal)
        self.topLabel.text = top.language
        self.botLabel.text = bottom.language
        clearText()
        params = ["source": top.code, "target": bottom.code]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCountry"{
            let destinationVC = segue.destination as! ChooseLangController
            destinationVC.delegate = self
        }
    }
}

/// ChooseLang  VIEW CONTROLLER


extension ChooseLangController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1) {
            return firstPickerOptions.count
        } else {
            return secondPickerOptions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1) {
            return firstPickerOptions[row].language
        } else {
            return secondPickerOptions[row].language
        }
    }
    
    func setPickerToUserSelect() {
        firstLanguagePicker.selectRow(defaults.integer(forKey: ChooseLangController.topLangPickerKey), inComponent: 0, animated: true)
        translatedLanguagePicker.selectRow(defaults.integer(forKey: ChooseLangController.bottomLangPickerKey), inComponent: 0, animated: true)
    }
    
}
