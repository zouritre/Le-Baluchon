//
//  GetCurrency.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 23/05/2022.
//

import Foundation

class CurrencyService {
    
    static func getCurrencies(completionHandler: @escaping (_ currencies: [String:String]?, _ error: NetworkRequestError?) -> Void) {
 
        NetworkService.shared.makeRequest(request: FixerApi.requestGetSymbol, dataStructure: CurrencySymbolJson()) { data, error in
            
            guard let data = data as? CurrencySymbolJson, error == nil else {
                
                completionHandler(nil, error)
                
                return
            }
            
            completionHandler(data.symbols, error)
        }
    }
    
    static func convertCurrencies(from: String, to: String, amount: String, completionHandler: @escaping (_ result: Float?, _ error: NetworkRequestError?) -> Void) {
        
        FixerApi.convert = ConvertCurrency(from: from, to: to, amount: amount)
        
        NetworkService.shared.makeRequest(request: FixerApi.requestConvertCurrency, dataStructure: CurrencyConversionJSON()) { data, error in
            
            guard let data = data as? CurrencyConversionJSON, error == nil else {
                
                completionHandler(nil, error)
                
                return
            }
            
            completionHandler(data.result, error)
        }
    }
    
}
