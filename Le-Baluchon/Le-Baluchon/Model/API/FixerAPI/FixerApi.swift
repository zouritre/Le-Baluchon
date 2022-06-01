//
//  ApiUrl.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 23/05/2022.
//

import Foundation

struct FixerApi {
    
    private static let root = "https://api.apilayer.com/fixer"
    
    static let apikey = "eQ7AZvkH1sZInoQJJXKH4tBbapC7zVBh"
    
    private static let currencySymbol = "/symbols"
    
    private static let convertCurrency = "/convert"
    
    static var convert = ConvertCurrency(from: "", to: "", amount: "")
    
    static var requestGetSymbol: URLRequest {
        var request = URLRequest(url: URL(string: "\(FixerApi.root)\(FixerApi.currencySymbol)")!)
        request.httpMethod = "GET"
        request.setValue(apikey, forHTTPHeaderField: "apikey")
        
        return request
    }
    
    static var requestConvertCurrency: URLRequest {
        var request = URLRequest(url: URL(string: "\(root)\(convertCurrency)?to=\(convert.to)&from=\(convert.from)&amount=\(convert.amount)")!)
        request.httpMethod = "GET"
        request.setValue(apikey, forHTTPHeaderField: "apikey")
        
        return request
    }

}
