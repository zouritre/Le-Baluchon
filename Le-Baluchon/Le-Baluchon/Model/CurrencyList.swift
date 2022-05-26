//
//  CurrencyList.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 23/05/2022.
//

import Foundation

struct CurrencyList: Decodable {
    let symbols: [CurrencySymbolJson]
}
