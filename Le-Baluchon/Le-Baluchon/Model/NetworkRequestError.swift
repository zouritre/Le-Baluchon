//
//  networkRequestError.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 01/06/2022.
//

import Foundation

enum NetworkRequestError: String {
    
case unexpectedError = "An error occured when retrieving data"
    
case connexionFailure = "Received incorrect response from server"

case unexpectedData = "Data decoding failed"
}
