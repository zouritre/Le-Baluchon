//
//  CityList.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 09/06/2022.
//

import Foundation

enum CityList: Int {
    
    case lyon = 0
    
    case newYork = 1
    
    func info() -> CityInfo {
        
        switch self {
            
        case .lyon: return CityInfo(name: "Lyon", zipcode: 69000, countryCode: "fr")
        
        case .newYork: return CityInfo(name: "New York", zipcode: 10001, countryCode: "us")
            
        }
    }
}
