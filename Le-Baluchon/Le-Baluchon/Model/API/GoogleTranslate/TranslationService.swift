//
//  TranslationService.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 01/06/2022.
//

import Foundation

class TranslationService {
    
    static func translateWithAutoDetectLanguage(q: String, source: String?, target: String, completionHandler: @escaping (_ translation: String?, _ error: NetworkRequestError?) -> Void) {
        GoogleTranslateAPI.translationData = TranslationData(q: q, source: source, target: target)
        
        detectLanguage(q: q){ languageCode, error in
            
            guard let languageCode = languageCode else {
                
                completionHandler(nil, error)
                
                return
            }
            
            GoogleTranslateAPI.translationData.source = languageCode
            
            translateText{ translation, error in
                
                guard let translation = translation else {
                    completionHandler(nil, error)
                    return
                }

                completionHandler(translation, nil)
                
            }
        }

    }
    
    private static func detectLanguage(q: String, completionHandler: @escaping (_ languageCode: String?, _ error: NetworkRequestError?) -> Void) {
        NetworkService.shared.makeRequest(request: GoogleTranslateAPI.requestAutoDetectLanguage, dataStructure: AutoDetectLanguageJSON()) {languageCode, error in
            
            guard let languageCode = languageCode as? AutoDetectLanguageJSON else {
                
                completionHandler(nil, error)
                
                return
            }
            
            completionHandler(languageCode.data.detections[0][0].language, error)
        }
    }
    
    private static func  translateText(completionHandler: @escaping (_ translation: String?, _ error: NetworkRequestError?) -> Void) {
        
        NetworkService.shared.makeRequest(request: GoogleTranslateAPI.requestTranslateText, dataStructure: TextTranslationJSON()) {translation, error in
            
            guard let translation = translation as? TextTranslationJSON else {
                completionHandler(nil, error)

                return
            }
            
            completionHandler(translation.data.translations[0].translatedText, nil)
        }
        
    }
}
