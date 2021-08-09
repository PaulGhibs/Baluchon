//
//  File.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 03/08/2021.
//

import UIKit

protocol chooseLanguague {
    func userChooseNewLanguage(top: taLang, bottom: taLang)
}

class ChooseLangController: UIViewController {
    // MARK: - Properties
    let defaults = UserDefaults.standard
    static let topLangPickerKey = "topTranslatorPicker"
    static let bottomLangPickerKey = "bottomTranslatorPicker"
    static let topLangCodeKey = "topTranslatorCode"
    static let bottomLangCodeKey = "bottomTranslatorCode"
    static let topLanguageKey = "topLanguage"
    static let bottomLanguageKey = "bottomLanguage"
    static let topLangImageKey = "topTranslatorImage"
    static let bottomLangImageKey = "bottomTranslatorImage"
    // MARK: - Outlets

    @IBOutlet weak var firstLanguagePicker: UIPickerView!
    @IBOutlet weak var translatedLanguagePicker: UIPickerView!
    
    var delegate: chooseLanguague?
    var userChoice: Languages!
    var languages = WorldLanguages()
    var firstPickerOptions = [(code: String, language: String, flag: UIImage, country: String)]()
    var secondPickerOptions = [(code: String, language: String, flag: UIImage, country: String)]()

    // MARK: - Actions

    @IBAction func saveSettings(_ sender: Any) {
        createFirstAndSecondChoice()
        delegate?.userChooseNewLanguage(top: userChoice.top, bottom: userChoice.bot)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstLanguagePicker.delegate = self
        self.firstLanguagePicker.dataSource = self
        self.translatedLanguagePicker.delegate = self
        self.translatedLanguagePicker.dataSource = self
        firstPickerOptions = languages.worldLanguages
        secondPickerOptions = languages.worldLanguages
        setPickerToUserSelect()
        
    }
    
    func createFirstAndSecondChoice(){
        let firstUserIndex = firstLanguagePicker.selectedRow(inComponent: 0)
        let secondUserIndex = translatedLanguagePicker.selectedRow(inComponent: 0)
        let firstUserChoice = languages.worldLanguages[firstUserIndex]
        let secondUserChoice = languages.worldLanguages[secondUserIndex]
        userChoice = Languages(top: firstUserChoice, bot: secondUserChoice )
        
        // save choices
        defaults.set(firstUserIndex, forKey: ChooseLangController.topLangPickerKey)
        defaults.set(secondUserIndex, forKey: ChooseLangController.bottomLangPickerKey)
        defaults.set(userChoice.top.code, forKey: ChooseLangController.topLangCodeKey)
        defaults.set(userChoice.bot.code, forKey: ChooseLangController.bottomLangCodeKey)
        defaults.set(userChoice.top.language, forKey: ChooseLangController.topLanguageKey)
        defaults.set(userChoice.bot.language, forKey: ChooseLangController.bottomLanguageKey)
        defaults.set(userChoice.top.country, forKey: ChooseLangController.topLangImageKey)
        defaults.set(userChoice.bot.country, forKey: ChooseLangController.bottomLangImageKey)
        
    }
    
    
    
}


