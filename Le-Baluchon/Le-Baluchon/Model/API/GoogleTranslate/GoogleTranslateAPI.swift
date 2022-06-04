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
    
    private static let rootAutoDetectLanguage = "https://translation.googleapis.com/language/translate/v2/detect"
    
    private static let rootLanguagesCode = "https://translation.googleapis.com/language/translate/v2/languages"
    
    private static let apiKey = "AIzaSyCDMD5VoCRCWBR_ALrbmvnUZf8-QzNCyyY"
    
    /// Translation format, either text or html
    private static let translationFormat = "text"
    
    /// The language in wich to translate the returned language names
    private static var languageNamesTarget = "fr"
    
    static var q: String?
    static var target: String?
    static var source: String?
    
    
    
    static var requestTranslateText: URLRequest {
        
        let translateTextUrlString = "\(self.rootTranslate)?key=\(apiKey)&format=\(translationFormat)&q=\(q!)&target=\(target!)&source=\(source!)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        var request = URLRequest(url: URL(string: translateTextUrlString)!)
        request.httpMethod = "POST"
        
        return request
    }
    
    static var requestAutoDetectLanguage: URLRequest {
        
        let autoDetectLanguageUrlString = "\(rootAutoDetectLanguage)?key=\(apiKey)&q=\(q!)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        var request = URLRequest(url: URL(string: autoDetectLanguageUrlString)!)
        request.httpMethod = "POST"
        
        return request
    }
    
    static var requestSupportedLanguages: URLRequest {
        
        var request = URLRequest(url: URL(string: "\(rootLanguagesCode)?key=\(apiKey)&target=\(languageNamesTarget)")!)
        request.httpMethod = "GET"
        
        return request
    }

}
