//
//  CurrencySymbol.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 23/05/2022.
//

import Foundation

struct CurrencySymbolJson: Decodable {
    var success: Bool = true
    var symbols: [String:String] = [:]
}

struct CurrencyConversionJSON: Decodable {
    
    var success = true
    var query = ConversionQuery()
    var info: [String:Float] = [:]
    var date: String = ""
    var result: Float = 0
}

struct ConversionQuery: Decodable {
    
    var from: String = ""
    var to: String = ""
    var amount: Float = 0
}
