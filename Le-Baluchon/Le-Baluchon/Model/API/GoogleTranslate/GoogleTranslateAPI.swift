//
//  GoogleTranslateAPI.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 31/05/2022.
//

import Foundation

struct GoogleTranslateAPI {
    
    /// API root URL
    private static let rootTranslate = "https://translation.googleapis.com/language/translate/v2"
    
    /// Subdirectory of language detection API calls
    private static let rootAutoDetectLanguage = "https://translation.googleapis.com/language/translate/v2/detect"
    
    /// Subdirectory of the API to retrieve supported languages for translation
    private static let rootLanguagesCode = "https://translation.googleapis.com/language/translate/v2/languages"
    
    /// Translation format, either text or html
    private static let translationFormat = "text"
    
    /// The language in wich to format the server response
    private static var languageNamesTarget = "fr"
    
    /// Text to be translated
    static var q: String?
    
    /// Target language of the translation
    static var target: String?
    
    /// Source language of the translation
    static var source: String?
    
    /// Return the request to be sent to the API to get the provided text translation according the the source and target language
    static var requestTranslateText: URLRequest {
        
        let translateTextUrlString = "\(self.rootTranslate)?key=\(Constant.GoogleranslationApiKey)&format=\(translationFormat)&q=\(q!)&target=\(target!)&source=\(source!)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        var request = URLRequest(url: URL(string: translateTextUrlString)!)
        request.httpMethod = "POST"
        
        return request
    }
    
    /// Return the request to be sent to the API  to get the provided text source language implicitly
    static var requestAutoDetectLanguage: URLRequest {
        
        let autoDetectLanguageUrlString = "\(rootAutoDetectLanguage)?key=\(Constant.GoogleranslationApiKey)&q=\(q!)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        var request = URLRequest(url: URL(string: autoDetectLanguageUrlString)!)
        request.httpMethod = "POST"
        
        return request
    }
    
    //Return the request to be sent to the API to get the list of all supported languages for translation
    static var requestSupportedLanguages: URLRequest {
        
        var request = URLRequest(url: URL(string: "\(rootLanguagesCode)?key=\(Constant.GoogleranslationApiKey)&target=\(languageNamesTarget)")!)
        request.httpMethod = "GET"
        
        return request
    }

}
