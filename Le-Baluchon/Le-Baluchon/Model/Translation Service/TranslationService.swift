//
//  TranslationService.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 01/06/2022.
//

import Foundation

class TranslationService {
    
    /// Detect the insert text language
    /// - Parameters:
    ///   - q: The text to be processed
    ///   - completionHandler: Return the language code or an error
    static func detectLanguage(q: String, completionHandler: @escaping (_ languageCode: String?, _ error: NetworkRequestError?) -> Void) {
        
        GoogleTranslateAPI.q = q
        
        NetworkService.shared.makeRequest(request: GoogleTranslateAPI.requestAutoDetectLanguage, dataStructure: AutoDetectLanguageJSON()) {languageCode, error in
            
            guard let languageCode = languageCode else {
                
                completionHandler(nil, error)
                
                return
            }
            
            completionHandler(languageCode.data.detections[0][0].language, error)
        }
    }
    
    /// Translate the provided text given a source language and a target language
    /// - Parameters:
    ///   - q: Text to be translated
    ///   - source: Source language
    ///   - target: Target language
    ///   - completionHandler: Return the translation of the provided text or an error
    static func  translateText(q: String, source: String, target: String, completionHandler: @escaping (_ translation: String?, _ error: NetworkRequestError?) -> Void) {
        
        GoogleTranslateAPI.q = q
        GoogleTranslateAPI.target = target
        GoogleTranslateAPI.source = source

        NetworkService.shared.makeRequest(request: GoogleTranslateAPI.requestTranslateText, dataStructure: TextTranslationJSON()) {translation, error in
            
            guard let translation = translation else {
                completionHandler(nil, error)

                return
            }
            
            completionHandler(translation.data.translations[0].translatedText, nil)
        }
        
    }
    
    /// Get a list of all supported languages to chose for translation
    /// - Parameter completionHandler: Return a list of all available languages or an error
    static func getSupportedLanguages(completionHandler: @escaping (_ languageDatas: [Language]?, _ error: NetworkRequestError?) -> Void) {
        
        NetworkService.shared.makeRequest(request: GoogleTranslateAPI.requestSupportedLanguages, dataStructure: SupportedLanguagesJSON()) { languages, error in

                guard let languages = languages else {
                    completionHandler(nil, error)
                    return
                }
                
                completionHandler(languages.data.languages, nil)
            }
    }
}
