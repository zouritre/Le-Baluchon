//
//  ApiUrl.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 23/05/2022.
//

import Foundation

struct FixerApi {
    
    //Url of the API provider
    private static let root = "https://api.apilayer.com/fixer"
    
    /// Subdirectory for calls to retrieve supported currency symbols and names
    private static let currencySymbol = "/symbols"
    
    /// Subdirectory for calls to convert currencies to another
    private static let convertCurrency = "/convert"
    
    /// Currency to convert
    static var from = ""
    
    /// Target currency for conversion
    static var to = ""
    
    /// Amount of currency to convert
    static var amount = ""
    
    /// Return the request  to be sent to the API to retrieve supported currency symbols and names
    static var requestGetSymbol: URLRequest {
        var request = URLRequest(url: URL(string: "\(FixerApi.root)\(FixerApi.currencySymbol)")!)
        request.httpMethod = "GET"
        request.setValue(Constant.FixerApiKey, forHTTPHeaderField: "apikey")
        
        return request
    }
    
    /// Return the request  to be sent to the API  to get the conversion of one currency to another according to the data provided by the user
    static var requestConvertCurrency: URLRequest {
        var request = URLRequest(url: URL(string: "\(root)\(convertCurrency)?to=\(to)&from=\(from)&amount=\(amount)")!)
        request.httpMethod = "GET"
        request.setValue(Constant.FixerApiKey, forHTTPHeaderField: "apikey")
        
        return request
    }

}
