//
//  GetCurrency.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 23/05/2022.
//

import Foundation

class CurrencyService {

    //Create a shared instance of the class to prevent any duplicates
    static var shared = CurrencyService()
    
    private var task: URLSessionDataTask?
    
    var session = URLSession(configuration: .default)
    
    private init() {}
    
    /// Retrieve currencies symbol and name from API
    /// - Parameter completionHandler: Dictionnary containing each currency symbol as keys and names as values
    func getCurrencies(completionHandler: @escaping (_ currencies: [String:String]?, _ error: String?) -> Void) {
        
        //Create a GET request to Fixer API by providing an API key
        var request = URLRequest(url: FixerApi.currencySymbolUrl)
        
        request.httpMethod = "GET"
        request.setValue(FixerApi.apikey, forHTTPHeaderField: "apikey")
        
        //Cancel current task if any
        task?.cancel()
        
        //Send the request to the API, manage potential errors and decode the JSON response.
        task = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                
                completionHandler(nil, "Error: \(error.localizedDescription)")
                
                return

            }
            
            guard let data = data else {
                
                completionHandler(nil, "No data received")
                
                return
                
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                completionHandler(nil, "Connexion failed")

                return
                
            }
            
            guard let responseJSON = try? JSONDecoder().decode(CurrencySymbolJson.self, from: data) else {
                
                completionHandler(nil, "Data decoding failed")

                return
                
            }
            
            completionHandler(responseJSON.symbols, nil)
            
        }
        
        task?.resume()
        
    }
}
