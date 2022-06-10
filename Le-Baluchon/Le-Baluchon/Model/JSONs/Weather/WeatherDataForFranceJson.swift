//
//  WeatherDataJson.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 06/06/2022.
//

import Foundation

struct WeatherDataForFranceJson: Decodable {
    
    var coord = WeatherCoordData()
    
    var weather = [WeatherWeatherData()]
    
    var base = ""
    
    var main = WeatherMainData()
    
    var visibility: Float = 0
    
    var wind = WeatherWindFranceData()
    
    var clouds = WeatherCloudData()
    
    var dt: Float = 0
    
    var sys = WeatherSysData()
    
    var timezone = 0
    
    var id = 0
    
    var name = ""
    
    var cod = 0
    
}

// New structure because of server response is slightly different for France
struct WeatherWindFranceData: Decodable {
    
    var speed: Float = 0
    
    var deg: Float = 0
    
}

