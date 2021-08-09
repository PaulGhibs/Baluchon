//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 28/07/2021.
//

import Foundation
import UIKit

class TranslateViewController: UIViewController {
    // MARK: - Properties
    let defaults = UserDefaults.standard
    var params = [String: String]()
    // MARK: - Outlets
    @IBOutlet weak var topFlag: UIButton!
    @IBOutlet weak var botFlag: UIButton!
    @IBOutlet weak var translatorInput: UITextView!
    @IBOutlet weak var translatorOutput: UITextView!
    @IBOutlet weak var botLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var langButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpParamsAtLaunch()
    }
    
    // MARK: - Actions
    @IBAction func switchText(_ sender: UIButton) {
        clearText()
        TranslatorAPI.shared.swapTexts(&topLabel.text, &botLabel.text)
        TranslatorAPI.shared.swapTexts(&translatorInput.text, &translatorOutput.text)
        if let topFlagImageview = topFlag.imageView,
            let bottomFlagImageView = botFlag.imageView{
            topFlag.setImage(bottomFlagImageView.image, for: .normal)
            botFlag.setImage(topFlagImageview.image, for: .normal)
        }
        params = ["source": params["target"]!, "target": params["source"]!]
    }
    //Button pressed to get the translation
    @IBAction func translate(_ sender: UIButton) {
        translatorOutput.text! = ""
        TranslatorAPI.shared.getTranslation(q: translatorInput.text!, source: params["source"]!, target: params["target"]!) {
            (success,translationResult) in
            if success, let translationResult = translationResult{
                self.translatorOutput.text! = translationResult
            }
            else{
                self.presentAlert()
            }
        }
    }
    
    @IBAction func changeTopLang(_ sender: Any) {
        performSegue(withIdentifier: "changeCountry", sender: self)
    }
    
    @IBAction func changeBotLang(_ sender: Any) {
        performSegue(withIdentifier: "changeCountry", sender: self)
    }
    
    //Dismiss the keyboard when the user tap on the screen
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        translatorInput.resignFirstResponder()
        translatorOutput.resignFirstResponder()
    }
    
    //To erase the text input and output
    func clearText(){
        translatorInput.text! = ""
        translatorOutput.text! = ""
    }
    
  }


