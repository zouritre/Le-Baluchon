//
//  GeoData.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 06/06/2022.
//

import Foundation

struct GeoDataJson: Decodable {
    
    var zip = ""
    
    var name = ""
    
    var lat: Float = 0
    
    var lon: Float = 0
    
    var country = ""
    
}
