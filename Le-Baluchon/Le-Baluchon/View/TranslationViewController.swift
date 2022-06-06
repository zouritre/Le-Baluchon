//
//  TranslationViewController.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 02/06/2022.
//

import UIKit

extension TranslationViewController: LanguageSelectionDelegate {
    
    func selectedLanguage(language: String, languageCode: String) {
        
        DispatchQueue.main.async {
            
            guard let sender = self.sender else {
                return
            }
                        
            if sender.tag == 0 {
                
                self.autoDetectSwitch.isOn = false
                
                self.sender?.setTitle(language, for: .normal)
                
                self.sourceLanguageName = language
                self.sourceLanguageCode = languageCode
                
                // Send a translation request
                self.translateTextAfter(timer: 0.0)
                
            }
            else if sender.tag == 1 {
                
                self.targetLanguageName = language
                self.targetLanguageCode = languageCode
                
                // Send a translation request
                self.translateTextAfter(timer: 0.0)
                    
            }
        }
    }
}

extension TranslationViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        DispatchQueue.main.async {
            
            guard self.timer == nil else {
                
                self.timer!.invalidate()
                
                self.translateTextAfter(timer: 1.5)
                
                return
            
            }
            
            //Send a translation request 1.5 second after the text has last been changed
            self.translateTextAfter(timer: 1.5)
            
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text.count > self.maxCaracterAllowed {
            //If pasting a copied text wich exceed maximum caracters count
            
            DispatchQueue.main.async {
                
                self.alert(message: "Texte à coller trop volumineux")
                
            }
            
            //cancel the action
            return false
            
        }
        else if range.length == 1 && (1..<self.maxCaracterAllowed).contains(self.caracterCounter) {
            //Text being deleted when counter is below max and above zero, allow
            
            DispatchQueue.main.async {
                
                self.caracterCounterLabel.text = "\(self.caracterCounter - 1)/\(self.maxCaracterAllowed)"

            }
            
            return true
        
        }
        else if range.length == 1 && self.caracterCounter >= self.maxCaracterAllowed {
            //Text being deleted when counter is at max, allow
            
            DispatchQueue.main.async {
                
                self.caracterCounterLabel.text = "\(self.caracterCounter - 1)/\(self.maxCaracterAllowed)"

            }
            
            return true
            
        }
        else if range.length == 0 && text.count == 1 && self.caracterCounter < self.maxCaracterAllowed {
            //Caracter being added when counter is below max, allow
            
            DispatchQueue.main.async {
                
                self.caracterCounterLabel.text = "\(self.caracterCounter + 1)/\(self.maxCaracterAllowed)"
            
            }
            
            return true
        
        }
        else if range.length == 0 && text.count > 1 && self.caracterCounter + text.count < self.maxCaracterAllowed {
            //Text being added and total caracters sum is below max, allow
            
            DispatchQueue.main.async {
                
                self.caracterCounterLabel.text = "\(self.caracterCounter + 1)/\(self.maxCaracterAllowed)"
            
            }
            
            return true
        
        }
        else if range.length == 0 && text.count > 1 && self.caracterCounter + text.count == self.maxCaracterAllowed {
            //Text being added and total caracters sum is below max, allow
            
            DispatchQueue.main.async {
                
                self.caracterCounterLabel.text = "\(self.caracterCounter)/\(self.maxCaracterAllowed)"
            
            }
            
            return true
        
        }
        else {
            //Any other cases, not allow to add the text
            
            return false
            
        }
    }
}
class TranslationViewController: UIViewController {
    
    var textViewDelegate: UITextViewDelegate?
    
    var timer: Timer?
    
    /// Button wich opened the language picker view
    var sender: UIButton?
    
    var maxCaracterAllowed = 400
    
    
    var caracterCounter: Int {
        
            guard let textCounter = toBeTranslated.text?.count else {
                return 0
            }
            
            return textCounter
        
    }
    
    var sourceLanguageName = "Français" {
        
        didSet {
            
            //prevent source language name and target language name to be identical
            if targetLanguageName == sourceLanguageName {
                
                sourceLanguageName = oldValue
                
            }
        }
    }
    var sourceLanguageCode = "fr" {
        
        didSet {
            
            //prevent source language code and target language code to be identical
            if sourceLanguageCode == targetLanguageCode {
                
                sourceLanguageCode = oldValue
                
            }
        }
    }
    
    var targetLanguageName = "Anglais" {
        
        didSet {
            
            //prevent source language name and target language name to be identical
            if targetLanguageName == sourceLanguageName {
                
                targetLanguageName = oldValue
                
            }
        }
    }
    
    var targetLanguageCode = "en" {
        
        didSet {
            
            //prevent source language code and target language code to be identical
            if targetLanguageCode == sourceLanguageCode {
                
                targetLanguageCode = oldValue
                
            }
            else {
                targetLanguage.setTitle(targetLanguageName, for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Place the controller as delegate of UITextViewDelegate to retrieve text changes events
        toBeTranslated.delegate = self
        
    }
    
    @IBOutlet weak var caracterCounterLabel: UILabel!
    
    @IBOutlet weak var autoDetectSwitch: UISwitch!
    
    @IBOutlet weak var sourceLanguage: UIButton!
    
    @IBOutlet weak var targetLanguage: UIButton!
    
    @IBOutlet weak var toBeTranslated: UITextView!
    
    @IBOutlet weak var translatedText: UITextView!
    
    /// Set the source text language button title to "Auto" if "Auto-detection" is on otherwise set it to the selected language
    /// - Parameter sender: The switch of language auto-detection
    @IBAction func autoDetect(_ sender: UISwitch) {
        
        guard sender.isOn else {
            
            sourceLanguage.setTitle(sourceLanguageName, for: .normal)
            
            translateTextAfter(timer: 0.0)
            
            return
            
        }
        
        sourceLanguage.setTitle("Auto", for: .normal)
        
        translateTextAfter(timer: 0.0)
            
    }
    
    /// Clear the text fields and reset caracter counter
    /// - Parameter sender: UIButton
    @IBAction func clearTextButton(_ sender: Any) {
        
        toBeTranslated.text = ""
        translatedText.text = ""
        
        caracterCounterLabel.text = "\(self.caracterCounter)/\(self.maxCaracterAllowed)"    }
    
    /// Send a translation request on the source text field after a delay
    /// - Parameter timer: Number of seconds to wait before sending the request
    func translateTextAfter(timer: Double) {
        
        //Prevent execution if not text has been prvided
        guard toBeTranslated.text.count > 0 else {
            return
        }
        
        self.timer = Timer.scheduledTimer(withTimeInterval: timer, repeats: false) { [weak self] timer in
            
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                
                if self.autoDetectSwitch.isOn {
                    
                    self.translateTextWithAutoDetection()
                    
                }
                else {
                    
                    self.translateTextWithoutAutoDetection()
                    
                }
                
            }

        }
    }
    
    func translateTextWithAutoDetection() {
        
        //Detect the language code of the provided text to translate
        TranslationService.detectLanguage(q: self.toBeTranslated.text) { [weak self] languageCode, error in
            
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                
                guard error == nil else {
                    
                    self.alert(message: "Error when detecting language: \(error!.rawValue)")
                    
                    return
                    
                }
                
                guard let sourceLanguageCode = languageCode else {
                    
                    self.alert(message: "Error when detecting language: couldn't retrieve language code")
                    
                    return
                   
                }
                
                self.sourceLanguageCode = sourceLanguageCode
                
                //Translate the provided text
                self.translateTextWithoutAutoDetection()
 
            }
        }
    }
    
    func translateTextWithoutAutoDetection() {
        
        TranslationService.translateText(q: self.toBeTranslated.text, source: self.sourceLanguageCode, target: self.targetLanguageCode) { translation, error in
            
            DispatchQueue.main.async {
                
                guard error == nil else {
                    
                    self.alert(message: "Error when translating text without auto-detection: \(error!.rawValue)")
                    
                    return
                    
                }
                
                guard let translation = translation else {
                    
                    self.alert(message: "Error when translating text without auto-detection: couldn't retrieve translation")
                    
                    return
                
                }
                
                //Display the translated text
                self.translatedText.text = translation
                
            }
            
        }
    }
    
    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Place this view controller as delegate of LanguageSelectionDelegate protocol
        if let destination = segue.destination as? LanguageSelectionViewController {
            destination.languageSelectionDelegate = self
            self.sender = sender as? UIButton
        }
    }
    

}
