//
//  FakeCurrencySymbolResponse.swift
//  Le-BaluchonTests
//
//  Created by Bertrand Dalleau on 27/05/2022.
//

import Foundation

class FakeResponse {
   
    static let responseOK = HTTPURLResponse(
       url: URL(string: "https://openclassrooms.com")!,
       statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
       url: URL(string: "https://openclassrooms.com")!,
       statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    class CurrencyError: Error {}
    
    static let error = CurrencyError()
    
    static let incorrectData = "erreur".data(using: .utf8)
    
    private static let bundle = Bundle(for: FakeResponse.self)
    
    static var correctCurrencySymbolData: Data? {
    
        let url = bundle.url(forResource: "CurrencySymbol", withExtension: "json")!
        
        return try! Data(contentsOf: url)
    }
    
    static var correctCurrencyConversionData: Data? {
    
        let url = bundle.url(forResource: "CurrencyConversion", withExtension: "json")!
        
        return try! Data(contentsOf: url)
    }
    
    static var correctTranslationData: Data? {
    
        let url = bundle.url(forResource: "TextTranslationData", withExtension: "json")!
        
        return try! Data(contentsOf: url)
    }
    
    static var correctAutoDetectLanguageData: Data? {
    
        let url = bundle.url(forResource: "AutoDetectLanguageData", withExtension: "json")!
        
        return try! Data(contentsOf: url)
    }
    
    static var correctGetSupportedLanguagesData: Data? {
    
        let url = bundle.url(forResource: "GetSupportedLanguagesCode", withExtension: "json")!
        
        return try! Data(contentsOf: url)
    }
    
    static var correctGetCoordinatesData: Data? {
    
        let url = bundle.url(forResource: "GeoData", withExtension: "json")!
        
        return try! Data(contentsOf: url)
    }
    
    static var NewYorkWeatherData: Data? {
    
        let url = bundle.url(forResource: "NewYorkWeatherData", withExtension: "json")!
        
        return try! Data(contentsOf: url)
    }
    
    static var FranceWeatherData: Data? {
    
        let url = bundle.url(forResource: "FranceWeatherData", withExtension: "json")!
        
        return try! Data(contentsOf: url)
    }
}
