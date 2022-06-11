//
//  WeatherViewController.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 22/05/2022.
//

import UIKit

extension WeatherViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let weatherCell = WeatherDataCell.getCell(for: indexPath, in: collectionView)
        
//        DispatchQueue.main.async {
            self.setWeatherCellData(for: weatherCell)
//        }
        
        return weatherCell
        
    }
}
class WeatherViewController: UIViewController {

    var weatherService = WeatherService()
    
    var menuItemLyon: UIKeyCommand?
    
    var menuItemNY: UIKeyCommand?
    
    var menuItems: [UIKeyCommand] = []
    
    var weatherDetailValues: [String:String] = [:]
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCitySelectionMenu()
        
        getWeather()
        
        
    }
    
    @IBOutlet weak var weatherDetails: UICollectionView!
    
    @IBOutlet weak var citySelectionButton: UIButton!
    
    @IBOutlet weak var temperature: UILabel!
    
    @IBOutlet weak var weatherDescription: UILabel!
    
    @IBOutlet weak var min_temp: UILabel!
    
    @IBOutlet weak var max_temp: UILabel!
    
    ///  Set selected menu item state to on and disable the one previously selected
    /// - Parameter sender: The selected menu item
    @objc func selectCity(_ sender: UIKeyCommand) {
        
        // Set the selected item state to on
        menuItems.forEach{ item in
            
            if item.title == sender.title {
                // Set the selected item state to on
                item.state = .on
                
            }
            else {
                // Set the other items state to off
                item.state = .off
                
            }
            
        }
        
        // Recreate the button menu with new items while preserving its configuration
        citySelectionButton.menu = citySelectionButton.menu?.replacingChildren(menuItems)
        
        getWeather()
    }
    
    /// Create the menu for city selection
    func createCitySelectionMenu() {
        
        menuItemLyon = UIKeyCommand(title: CityList.lyon.info().name,
                                                       action: #selector(selectCity(_:)),
                                                       input: "L",
                                                       modifierFlags: .command)
        
        menuItemNY = UIKeyCommand(title: CityList.newYork.info().name,
                                      action: #selector(selectCity(_:)),
                                      input: "N",
                                      modifierFlags: .command)
        
        // Add designated cities as menu items
        menuItems.append(menuItemLyon!)
        menuItems.append(menuItemNY!)

        // Create city button menu
        let citySelectionMenu = UIMenu(title: "Sélectionnez une ville", options: .displayInline, children: [menuItemLyon!, menuItemNY!])
        
        citySelectionButton.menu = citySelectionMenu
    }
    
    func setWeatherCellData(for weatherCell: UICollectionViewCell) {
        
        switch weatherCell.tag {
            
        case WeatherDetailCell.wind.rawValue:

            guard let windSpeed = weatherCell.contentView.viewWithTag(WeatherDetailCellContent.windSpeed.rawValue) as? UILabel else {
                print("Couldn't set windSpeed")
                return
            }

            guard let windDrection = weatherCell.contentView.viewWithTag(WeatherDetailCellContent.windDirection.rawValue) as? UILabel else {
                print("Couldn't set windDrection")
                return
            }

            windSpeed.text = self.weatherDetailValues["wind_speed"]
            windDrection.text = self.weatherDetailValues["wind_direction"]
            
        case WeatherDetailCell.feels_like.rawValue:
            
            guard let feels_like = weatherCell.contentView.viewWithTag(WeatherDetailCellContent.feels_like.rawValue) as? UILabel else {
                print("Couldn't set feels_like")
                return
            }
            
            feels_like.text = self.weatherDetailValues["feels_like"]
            
        case WeatherDetailCell.pressure.rawValue:
            
            guard let pressure = weatherCell.contentView.viewWithTag(WeatherDetailCellContent.pressure.rawValue) as? UILabel else {
                print("Couldn't set pressure")
                return
            }
            
            pressure.text = self.weatherDetailValues["pressure"]
            
        case WeatherDetailCell.visibility.rawValue:
            
            guard let visibility = weatherCell.contentView.viewWithTag(WeatherDetailCellContent.visibility.rawValue) as? UILabel else {
                print("Couldn't set visibility")
                return
            }
            
            visibility.text = self.weatherDetailValues["visibility"]
            
        case WeatherDetailCell.humidity.rawValue:
            
            guard let humidity = weatherCell.contentView.viewWithTag(WeatherDetailCellContent.humidity.rawValue) as? UILabel else {
                print("Couldn't set humidity")
                return
            }
            
            humidity.text = self.weatherDetailValues["humidity"]
            
        case WeatherDetailCell.sun.rawValue:
            
            guard let sunrise = weatherCell.contentView.viewWithTag(WeatherDetailCellContent.sunrise.rawValue) as? UILabel else {
                print("Couldn't set sunrise")
                return
            }
            
            guard let sunset = weatherCell.contentView.viewWithTag(WeatherDetailCellContent.sunset.rawValue) as? UILabel else {
                print("Couldn't set sunset")
                return
            }
            
            sunrise.text = self.weatherDetailValues["sunrise"]
            sunset.text = self.weatherDetailValues["sunset"]
            
        default: return
            
        }
    }
    
    func getWeather() {
        
        var zip = 0
        
        var countryCode = ""
        
        var weatherForFrance: Bool = false
        
        // Set zip and countryCode variables with selected city info
        switch citySelectionButton.menu?.selectedElements[0].title {
            
        case CityList.lyon.info().name:
            zip = CityList.lyon.info().zipcode
            countryCode = CityList.lyon.info().countryCode
            weatherForFrance = true
            
        case CityList.newYork.info().name:
            zip = CityList.newYork.info().zipcode
            countryCode = CityList.newYork.info().countryCode
            weatherForFrance = false
            
        default:
            alert(message: "Couldn't set selected city parameter to weather request")
            return
        }
        
        print("zip: \(zip) \nCode: \(countryCode)")
        //Get coordinates of selected city then get its weather data
        weatherService.getCoordinates(zip: zip, countryCode: countryCode) { [weak self] coords, error in
            
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                
                guard error == nil else {
                    
                    self.alert(message: "Error when requesting city coordinates: \(error!.rawValue)")
                    
                    return
                    
                }
                
                guard let lat = coords?["lat"],  let lon = coords?["lon"] else {
                    
                    self.alert(message: "Error when retrieving coordinates: data was null")
                    
                    return
                   
                }
                
                self.weatherService.getWeather(lat: lat, lon: lon, forFrance: weatherForFrance)  { weather, error in
                    
                    DispatchQueue.main.async {
                        
                        guard error == nil else {
                            
                            self.alert(message: "Error when requesting weather: \(error!.rawValue)")
                            
                            return
                            
                        }
                        
                        guard let temp = weather?["temperature"] else {
                            return 
                        }
                        
                        guard let description = weather?["description"] else {
                            return
                        }
                        
                        guard let temp_min = weather?["temp_min"] else {
                            return
                        }
                        
                        guard let temp_max = weather?["temp_max"] else {
                            return
                        }
                        
                        guard let feels_like = weather?["feels_like"] as? Float else {
                            return
                        }
                        
                        guard let pressure = weather?["pressure"] as? Float else {
                            return
                        }
                        
                        guard let humidity = weather?["humidity"] as? Float else {
                            return
                        }
                        
                        guard let wind_direction = weather?["wind_direction"] as? Float else {
                            return
                        }
                        
                        guard let wind_speed = weather?["wind_speed"] as? Float else {
                            return
                        }
                        
                        guard let visibility = weather?["visibility"] as? Float else {
                            return
                        }
                        
                        guard let sunrise = weather?["sunrise"] as? Int else {
                            return
                        }
                        
                        guard let sunset = weather?["sunset"] as? Int else {
                            return
                        }

                        print("feels_like: \(feels_like)")
                        print("pressure: \(pressure)")
                        print("humidity: \(humidity)")
                        print("visibility: \(visibility)")
                        print("sunrise: \(sunrise)")
                        print("sunset: \(sunset)")
                        print("wind_direction: \(wind_direction)")
                        print("wind_speed: \(wind_speed)")

                        //Set UILabels outlets values
                        self.temperature.text = "\(temp)°C"
                        self.weatherDescription.text = "\(description)".capitalized
                        self.min_temp.text = "Min. \(temp_min)°C"
                        self.max_temp.text = "Max. \(temp_max)°C"
                        
                        //Set dictionnary values used by UICollectionViewDataSource protocol
                        self.weatherDetailValues["feels_like"] = "\(feels_like) °C"
                        self.weatherDetailValues["pressure"] = "\(pressure) hPa"
                        self.weatherDetailValues["humidity"] = "\(humidity) %"
                        self.weatherDetailValues["wind_direction"] = "\(wind_direction) °"
                        self.weatherDetailValues["wind_speed"] = "\(wind_speed) km/h"
                        self.weatherDetailValues["visibility"] = "\(visibility) m"
                        
                        let dateFormatter = DateFormatter()

                        dateFormatter.dateFormat = "hh'H'mm"

                        let sunriseTime = Date(timeIntervalSince1970: TimeInterval(sunrise))
                        
                        self.weatherDetailValues["sunrise"] = "Levé: \(dateFormatter.string(from: sunriseTime))"

                        let sunsetTime = Date(timeIntervalSince1970: TimeInterval(sunset))

                        self.weatherDetailValues["sunset"] = "Couché: \(dateFormatter.string(from: sunsetTime))"
                        
                        self.weatherDetails.reloadData()
                        
                    }
                }
 
            }
            
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
