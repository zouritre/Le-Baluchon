//
//  GetCurrency.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 23/05/2022.
//

import Foundation

class CurrencyService {

    
    /// Retrieve currencies symbol and name from API
    /// - Parameter completionHandler: Dictionnary containing each currency symbol as keys and names as values
    static func getCurrencies(completionHandler: @escaping (_ currencies: [String:String]?, _ error: String?) -> Void) {
        
        //Create a GET request to Fixer API by providing an API key
        var request = URLRequest(url: FixerApi.currencySymbolUrl)
        
        request.httpMethod = "GET"
        request.setValue("uynnW4g7yQfGYHjWOPkoWHL2buhyQyGj", forHTTPHeaderField: "apikey")
        
        //Send the request to the API, manage potential errors and decode the JSON response.
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                
                if let error = error {
                    
                    completionHandler(nil, error.localizedDescription)
                    
                }
                
                return
                
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                completionHandler(nil, "Connexion failed")

                return
                
            }
            
            guard let responseJSON = try? JSONDecoder().decode(CurrencySymbolJson.self, from: data) else {
                
                completionHandler(nil, "Response decoding failed")

                return
                
            }
            
            completionHandler(responseJSON.symbols, nil)
            
        }.resume()
    }
}
