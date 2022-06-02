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
            
            sender.setTitle(language, for: .normal)
            
            if sender.tag == 0 {
                
                self.sourceLanguageName = language
                self.sourceLanguageCode = languageCode
            }
            else if sender.tag == 1 {
                self.targetLanguageName = language
                self.targetLanguageCode = languageCode
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
            
            self.translateTextAfter(timer: 1.5)
            
        }
    }
}
class TranslationViewController: UIViewController {
    
    var textViewDelegate: UITextViewDelegate?
    
    var timer: Timer?
    var sender: UIButton?
    
    var autoDetectLanguage: Bool = true
    
    var sourceLanguageName = "Français"
    var sourceLanguageCode = "fr"
    
    var targetLanguageName = "Anglais"
    var targetLanguageCode = "en"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        toBeTranslated.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func autoDetect(_ sender: UISwitch) {
        autoDetectLanguage = !autoDetectLanguage
        
        if autoDetectLanguage {
            
            sourceLanguage.setTitle("Auto", for: .normal)
            
        }
        else {
            
            sourceLanguage.setTitle(sourceLanguageName, for: .normal)
        }
    }
    
    @IBOutlet weak var sourceLanguage: UIButton!
    
    @IBOutlet weak var targetLanguage: UIButton!
    
    @IBOutlet weak var toBeTranslated: UITextView!
    
    @IBOutlet weak var translatedText: UITextView!
    
    
    func translateTextAfter(timer: Double) {
        
        self.timer = Timer.scheduledTimer(withTimeInterval: timer, repeats: false) { timer in
            print("Timer fired!")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LanguageSelectionViewController {
            destination.languageSelectionDelegate = self
            self.sender = sender as? UIButton
        }
    }
    

}
