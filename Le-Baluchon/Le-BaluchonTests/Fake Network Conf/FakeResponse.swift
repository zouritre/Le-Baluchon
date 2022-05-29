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
    
    private static let bundle = Bundle(for: FakeResponse.self)
    
    static var correctCurrencySymbolData: Data? {
    
        let url = bundle.url(forResource: "CurrencySymbol", withExtension: "json")!
        
        return try! Data(contentsOf: url)
    }
    
    static var correctCurrencyConversionData: Data? {
    
        let url = bundle.url(forResource: "CurrencyConversion", withExtension: "json")!
        
        return try! Data(contentsOf: url)
    }
    
    static let incorrectCurrencyData = "erreur".data(using: .utf8)
}
