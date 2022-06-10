//
//  WeatherService.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 06/06/2022.
//

import Foundation

class WeatherService {
    
    var weatherApi = OpenWeather()
    
    func getCoordinates(zip: Int, countryCode: String, completionHandler: @escaping ([String:Float]?, NetworkRequestError?) -> Void) {
        
        let request = weatherApi.geoDataRequest(zip: String(zip), countryCode: countryCode)
        
        NetworkService.shared.makeRequest(request:  request, dataStructure: GeoDataJson()) {geoData, error in
            
            guard let geoData = geoData else {
                
                completionHandler(nil, error)
                
                return
            }
            
            var coords = ["lat": geoData.lat]
            
            coords["lon"] = geoData.lon
            
            completionHandler(coords, error)
            
        }
    }
    
    func getWeather(lat: Float, lon: Float, forFrance: Bool, completionHandler: @escaping ([String:Any]?, NetworkRequestError?) -> Void) {
        
        let request = weatherApi.weatherDataRequest(latitude: String(lat), longitude: String(lon))
        
        if forFrance {
            
            NetworkService.shared.makeRequest(request: request, dataStructure: WeatherDataForFranceJson()) {weatherData, error in
                
                guard let weatherData = weatherData else {
                    
                    completionHandler(nil, error)
                    
                    return
                }
                
                var weather: [String:Any] = [:]
                
                weather["temperature"] = weatherData.main.temp
                weather["description"] = weatherData.weather[0].description
                weather["temp_min"] = weatherData.main.temp_min
                weather["temp_max"] = weatherData.main.temp_max
                weather["feels_like"] = weatherData.main.feels_like
                weather["pressure"] = weatherData.main.pressure
                weather["humidity"] = weatherData.main.humidity
                weather["wind_direction"] = weatherData.wind.deg
                weather["wind_speed"] = weatherData.wind.speed
                weather["visibility"] = weatherData.visibility
                weather["sunrise"] = weatherData.sys.sunrise
                weather["sunset"] = weatherData.sys.sunset
                
                completionHandler(weather, nil)
                
            }
        }
        else {
            
            NetworkService.shared.makeRequest(request: request, dataStructure: WeatherDataForUnitedStatesJson()) {weatherData, error in
                
                guard let weatherData = weatherData else {
                    
                    completionHandler(nil, error)
                    
                    return
                }
                
                var weather: [String:Any] = [:]
                
                weather["temperature"] = weatherData.main.temp
                weather["description"] = weatherData.weather[0].description
                weather["temp_min"] = weatherData.main.temp_min
                weather["temp_max"] = weatherData.main.temp_max
                weather["feels_like"] = weatherData.main.feels_like
                weather["pressure"] = weatherData.main.pressure
                weather["humidity"] = weatherData.main.humidity
                weather["wind_direction"] = weatherData.wind.deg
                weather["wind_speed"] = weatherData.wind.speed
                weather["visibility"] = weatherData.visibility
                weather["sunrise"] = weatherData.sys.sunrise
                weather["sunset"] = weatherData.sys.sunset
                
                completionHandler(weather, nil)
                
            }
        }
    }
}
