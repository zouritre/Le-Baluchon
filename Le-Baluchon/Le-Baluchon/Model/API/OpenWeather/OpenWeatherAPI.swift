//
//  OpenWeather.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 06/06/2022.
//

import Foundation

class OpenWeather {
    
    /// API key
    private var appid = "b54cb236eb31cdc227a2d15c826950ff"
    
    /// Request output language
    private var lang = "fr"
    
    /// Get the temperature in Celsius
    private var units = "metric"
    
    private var rootUrlString = "https://api.openweathermap.org"
    
    private var weatherDataUrlString = "/data/2.5/weather"
    
    private var geoDataURLString = "/geo/1.0/zip"
    
    func weatherDataRequest(latitude: String, longitude: String) -> URLRequest {
        
        var request = URLRequest(url: URL(string: "\(rootUrlString)\(weatherDataUrlString)?lat=\(latitude)&lon=\(longitude)&units=\(units)&lang=\(lang)&appid=\(appid)")!)
        request.httpMethod = "GET"
        
        return request
    }
    
    func geoDataRequest(zip: String, countryCode: String) -> URLRequest {
        
        var request = URLRequest(url: URL(string: "\(rootUrlString)\(geoDataURLString)?zip=\(zip),\(countryCode)&appid=\(appid)")!)
        request.httpMethod = "GET"
        
        return request
    }
    
    
    
    
}
