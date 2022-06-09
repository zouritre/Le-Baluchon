//
//  NetworkService.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 01/06/2022.
//

import Foundation

class NetworkService {
    
    private init() {}
    
    //Create a shared instance of the class to prevent any duplicates
    static var shared = NetworkService()
    
    //Allow task cancel and resume
    private var task: URLSessionDataTask?
    
    /// URLSession to be used, in testings it will be a "fake" session
    var session = URLSession(configuration: .default)
    
    /// Retrieve currencies symbol and name from API
    /// - Parameter completionHandler: Dictionnary containing each currency symbol as keys and names as values
    func makeRequest<anyDecodable:Decodable>(request: URLRequest, dataStructure: anyDecodable , completionHandler: @escaping (_ data: anyDecodable?, _ error: NetworkRequestError?) -> Void) {
        
        //Cancel current task if any
        task?.cancel()
        
        //Send the request to the API, manage potential errors and decode the JSON response.
        task = session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, .unexpectedError)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, .connexionFailure)
                return
            }
            
            guard let responseJSON = try? JSONDecoder().decode(type(of: dataStructure), from: data) else {
                completionHandler(nil, .unexpectedData)
                return
            }
            
            completionHandler(responseJSON, nil)
            
        }
        
        task?.resume()
        
    }
    
}
