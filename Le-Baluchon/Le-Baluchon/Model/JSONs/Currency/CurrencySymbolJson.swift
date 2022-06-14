//
//  CurrencySymbol.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 23/05/2022.
//

import Foundation

struct CurrencySymbolJson: Decodable {
    let success: Bool
    let symbols: [String:String]
    
    //Allow initialization without parameters, init content does not matter
    init() {
        self.success = true
        self.symbols = ["" : ""]
    }
}
