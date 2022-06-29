//
//  OpenWeather.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 06/06/2022.
//

import Foundation

class OpenWeather {
    
    /// Request output language
    private var lang = "fr"
    
    /// Get the temperature in Celsius
    private var units = "metric"
    
    //Url of the API provider
    private var rootUrlString = "https://api.openweathermap.org"
    
    /// Weather API subdirectory
    private var weatherDataUrlString = "/data/2.5/weather"
    
    /// Coordinates API subdirectory
    private var geoDataURLString = "/geo/1.0/zip"
    
    /// Request that get weather data given a set of coordinates
    /// - Parameters:
    ///   - latitude: Latitude of the location to get weather from
    ///   - longitude: Longitude  of the location to get weather from
    /// - Returns: Request to be sent according to the provided coordinates
    func weatherDataRequest(latitude: String, longitude: String) -> URLRequest {
        
        var request = URLRequest(url: URL(string: "\(rootUrlString)\(weatherDataUrlString)?lat=\(latitude)&lon=\(longitude)&units=\(units)&lang=\(lang)&appid=\(Constant.OpenWeatherMapAppId)")!)
        request.httpMethod = "GET"
        
        return request
    }
    
    /// Request to get  the coordinates of a location by providing its zipcode and countrycode
    /// - Parameters:
    ///   - zip: zipcode of the location to get coordinates from
    ///   - countryCode: country code  of the location to get coordinates from
    /// - Returns: Request to be sent according to the provided postal data
    func geoDataRequest(zip: String, countryCode: String) -> URLRequest {
        
        var request = URLRequest(url: URL(string: "\(rootUrlString)\(geoDataURLString)?zip=\(zip),\(countryCode)&appid=\(Constant.OpenWeatherMapAppId)")!)
        request.httpMethod = "GET"
        
        return request
    }
    
    
    
    
}
