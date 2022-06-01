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
    
    private static let apiKey = "AIzaSyCDMD5VoCRCWBR_ALrbmvnUZf8-QzNCyyY"
    
    /// Translation format, either text or html
    private static let translationFormat = "text"
    
    static var translationData = TranslationData(q: "")
    
    static var requestTranslateText: URLRequest {
        
        var request = URLRequest(url: URL(string: "\(rootTranslate)?key=\(apiKey)&format=\(translationFormat)&q=\(translationData.q)&target=\(translationData.target!)&source=\(translationData.source!)")!)
        request.httpMethod = "POST"
        
        return request
    }
    
    static var requestAutoDetectLanguage: URLRequest {
        
        var request = URLRequest(url: URL(string: "\(rootAutoDetectLanguage)?key=\(apiKey)&q=\(translationData.q)")!)
        request.httpMethod = "POST"
        
        return request
    }

}
