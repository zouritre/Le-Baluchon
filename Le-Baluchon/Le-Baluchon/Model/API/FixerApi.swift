//
//  ApiUrl.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 23/05/2022.
//

import Foundation

struct FixerApi {
    
    private static let root = "https://api.apilayer.com/fixer"
    
    private static let currencySymbol = "/symbols"
    
    static let apikey = "uynnW4g7yQfGYHjWOPkoWHL2buhyQyGj"
    
    static var currencySymbolUrl: URL {
        return URL(string: "\(root)\(currencySymbol)")!
    }

}
