//
//  LanguageSelectionViewController.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 02/06/2022.
//

import UIKit

extension LanguageSelectionViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.languages.count
    }
}
extension LanguageSelectionViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        // set pickerViews row to display each language name
        return self.languages[row]
    }
}

protocol LanguageSelectionDelegate: AnyObject {
    func selectedLanguage(language: String, languageCode: String)
}

class LanguageSelectionViewController: UIViewController {

    weak var languageSelectionDelegate: LanguageSelectionDelegate?
    
    var languages: [String] = []
    var languageCodes: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TranslationService.getSupportedLanguages { [weak self] languages, error in
            
            guard let self = self else {
                return
            }
            
            if error != nil {
                
                DispatchQueue.main.sync {
                    
                    //Display an alert with the error encountered
                    self.alert(message: error!.rawValue)
                    
                }
            }
            else {
                
                guard let languages = languages else {
                    self.alert(message: NetworkRequestError.unexpectedError.rawValue)
                    return
                }
                
                languages.forEach{ language in
                    
                    self.languages.append(language.name)
                    self.languageCodes.append(language.language)
                    
                }
                
                DispatchQueue.main.sync {
                    
                    self.languagePicker.reloadAllComponents()
                    
                }
            }
        }
    }
    
    @IBOutlet weak var languagePicker: UIPickerView!
    
    //Send selected language to main view controller on dismissal of this controller
    @IBAction func sendSelectedLanguage(_ sender: UITapGestureRecognizer) {
        
        if self.languages.count > 0 {
            
            let selectedLanguage = self.languages[languagePicker.selectedRow(inComponent: 0)]
            let selectedLanguageCode = self.languageCodes[languagePicker.selectedRow(inComponent: 0)]
            
            guard let languageSelectionDelegate = self.languageSelectionDelegate else {
                return
            }
            
            languageSelectionDelegate.selectedLanguage(language: selectedLanguage, languageCode: selectedLanguageCode)
            
        }
        
        dismiss(animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
