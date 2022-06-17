//
//  CurrencySymbol.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 18/06/2022.
//

import Foundation

struct CurrencySymbolJson: Decodable {
    var success: Bool = true
    var symbols: [String:String] = [:]
}
