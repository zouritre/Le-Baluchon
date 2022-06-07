//
//  GeoData.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 06/06/2022.
//

import Foundation

struct GeoDataJson: Decodable {
    
    var zip: String
    
    var name: String
    
    var lat: Float
    
    var lon: Float
    
    var country: String
    
    init() {
        self.zip = ""
        self.name = ""
        self.lat = 0
        self.lon = 0
        self.country = ""
    }
    
}
