//
//  conversionQueryJSON.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 29/05/2022.
//

import Foundation

struct ConversionQuery: Decodable {
    
    var from: String
    var to: String
    var amount: Float
    
    //Allow initialization without paramater, init content does not matter
    init() {
        self.from = ""
        self.to = ""
        self.amount = 0
    }
}
