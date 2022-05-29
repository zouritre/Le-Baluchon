//
//  CurrencyConversionJSON.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 29/05/2022.
//

import Foundation

struct CurrencyConversionJSON: Decodable {
    
    var success: Bool
    var query: ConversionQuery
    var info: [String:Float]
    var date: String
    var result: Float
    
    init(){
        self.success = true
        self.query = ConversionQuery()
        self.info = ["":0]
        self.date = ""
        self.result = 0.0
    }
}
