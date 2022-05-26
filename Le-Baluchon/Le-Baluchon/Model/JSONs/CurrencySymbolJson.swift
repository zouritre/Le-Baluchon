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
}
