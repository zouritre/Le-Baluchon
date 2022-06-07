//
//  WeatherDataJson.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 06/06/2022.
//

import Foundation

struct WeatherDataJson: Decodable {
    
    var coord = WeatherCoordData()
    
    var weather = [WeatherWeatherData()]
    
    var base = ""
    
    var main = WeatherMainData()
    
    var visibility: Float = 0
    
    var wind = WeatherWindData()
    
    var clouds = WeatherCloudData()
    
    var dt: Float = 0
    
    var sys = WeatherSysData()
    
    var timezone = 0
    
    var id = 0
    
    var name = ""
    
    var cod = 0
    
}

struct WeatherCoordData: Decodable {
    
    var lon: Float = 0
    var lat: Float = 0
}

struct WeatherWeatherData: Decodable {
    
    var id = 0
    var main = ""
    var description = ""
    var icon = ""
    
}

struct WeatherMainData: Decodable {
    
    var temp: Float = 0
    
    var feels_like: Float = 0
    
    var temp_min: Float = 0
    
    var temp_max: Float = 0
    
    var pressure: Float = 0
    
    var humidity: Float = 0
    
}

struct WeatherWindData: Decodable {
    
    var speed: Float = 0
    
    var deg: Float = 0
    
    var gust: Float = 0
    
}

struct WeatherCloudData: Decodable {
    
    var all: Float = 0
}

struct WeatherSysData: Decodable {
    
    var type = 0
    
    var id  = 0
    
    var country = ""
    
    var sunrise = 0
    
    var sunset = 0
}
