//
//  TranslationService.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 01/06/2022.
//

import Foundation

class TranslationService {
    
    static func detectLanguage(q: String, completionHandler: @escaping (_ languageCode: String?, _ error: NetworkRequestError?) -> Void) {
        
        GoogleTranslateAPI.translationData.q = q
        
        NetworkService.shared.makeRequest(request: GoogleTranslateAPI.requestAutoDetectLanguage, dataStructure: AutoDetectLanguageJSON()) {languageCode, error in
            
            guard let languageCode = languageCode as? AutoDetectLanguageJSON else {
                
                completionHandler(nil, error)
                
                return
            }
            
            completionHandler(languageCode.data.detections[0][0].language, error)
        }
    }
    
    static func  translateText(q: String, source: String, target: String, completionHandler: @escaping (_ translation: String?, _ error: NetworkRequestError?) -> Void) {
        
        GoogleTranslateAPI.translationData.q = q
        GoogleTranslateAPI.translationData.target = target
        GoogleTranslateAPI.translationData.source = source

        NetworkService.shared.makeRequest(request: GoogleTranslateAPI.requestTranslateText, dataStructure: TextTranslationJSON()) {translation, error in
            
            guard let translation = translation as? TextTranslationJSON else {
                completionHandler(nil, error)

                return
            }
            
            completionHandler(translation.data.translations[0].translatedText, nil)
        }
        
    }
}
