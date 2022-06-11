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
        
        let weatherCell = self.getCell(for: indexPath, in: collectionView)
        
        self.setWeatherCellData(for: weatherCell)
        
        return weatherCell
        
    }
}
class WeatherViewController: UIViewController {

    var weatherService = WeatherService()
    
    var menuItemLyon: UIKeyCommand?
    
    var menuItemNY: UIKeyCommand?
    
    /// Array contaning the items of the city selection button menu
    var menuItems: [UIKeyCommand] = []
    
    /// Contain the text to be displayed inside each labels of  UICollectionView corresponding to weather data
    var weatherDetailValues: [String:String] = [:]
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Set a gradient background
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
        
        //Request the weather for the selected city
        getWeather()
    }
    
    /// Create the menu for city selection button
    func createCitySelectionMenu() {
        
        menuItemLyon = UIKeyCommand(title: CityList.lyon.info().name,
                                                       action: #selector(selectCity(_:)),
                                                       input: "L",
                                                       modifierFlags: .command)
        
        menuItemNY = UIKeyCommand(title: CityList.newYork.info().name,
                                      action: #selector(selectCity(_:)),
                                      input: "N",
                                      modifierFlags: .command)
        
        // Store menu items in an array
        menuItems.append(menuItemLyon!)
        menuItems.append(menuItemNY!)

        // Create city button menu with the items previously created
        let citySelectionMenu = UIMenu(title: "Sélectionnez une ville", options: .displayInline, children: [menuItemLyon!, menuItemNY!])
        
        citySelectionButton.menu = citySelectionMenu
    }
    
    func getCell(for indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        
        switch indexPath.item {
            
        case 0: return collectionView.dequeueReusableCell(withReuseIdentifier: "wind", for: indexPath)
            
        case 1: return collectionView.dequeueReusableCell(withReuseIdentifier: "sun", for: indexPath)
        
        case 2: return collectionView.dequeueReusableCell(withReuseIdentifier: "feels_like", for: indexPath)
            
        case 3: return collectionView.dequeueReusableCell(withReuseIdentifier: "pressure", for: indexPath)
            
        case 4: return collectionView.dequeueReusableCell(withReuseIdentifier: "humidity", for: indexPath)
            
        case 5: return collectionView.dequeueReusableCell(withReuseIdentifier: "visibility", for: indexPath)
            
        default: return collectionView.dequeueReusableCell(withReuseIdentifier: "wind", for: indexPath)
            
        }
    }
    
    /// Retrieve the label(s) containing weather data inside each cell of the weather UICollectionView and define their value
    /// - Parameter weatherCell: The collection of weather datas
    func setWeatherCellData(for weatherCell: UICollectionViewCell) {
        
        switch weatherCell.tag {
            
        case WeatherDetailCellTag.wind.rawValue:

            //Retrieve the labels for wind speed and direction
            guard let windSpeed = weatherCell.contentView.viewWithTag(WeatherDetailCellContent.windSpeed.rawValue) as? UILabel else {
                print("Couldn't set windSpeed")
                return
            }

            guard let windDrection = weatherCell.contentView.viewWithTag(WeatherDetailCellContent.windDirection.rawValue) as? UILabel else {
                print("Couldn't set windDrection")
                return
            }

            //Set the value of each label with wind data
            windSpeed.text = self.weatherDetailValues["wind_speed"]
            windDrection.text = self.weatherDetailValues["wind_direction"]
            
        case WeatherDetailCellTag.feels_like.rawValue:
            
            guard let feels_like = weatherCell.contentView.viewWithTag(WeatherDetailCellContent.feels_like.rawValue) as? UILabel else {
                print("Couldn't set feels_like")
                return
            }
            
            feels_like.text = self.weatherDetailValues["feels_like"]
            
        case WeatherDetailCellTag.pressure.rawValue:
            
            guard let pressure = weatherCell.contentView.viewWithTag(WeatherDetailCellContent.pressure.rawValue) as? UILabel else {
                print("Couldn't set pressure")
                return
            }
            
            pressure.text = self.weatherDetailValues["pressure"]
            
        case WeatherDetailCellTag.visibility.rawValue:
            
            guard let visibility = weatherCell.contentView.viewWithTag(WeatherDetailCellContent.visibility.rawValue) as? UILabel else {
                print("Couldn't set visibility")
                return
            }
            
            visibility.text = self.weatherDetailValues["visibility"]
            
        case WeatherDetailCellTag.humidity.rawValue:
            
            guard let humidity = weatherCell.contentView.viewWithTag(WeatherDetailCellContent.humidity.rawValue) as? UILabel else {
                print("Couldn't set humidity")
                return
            }
            
            humidity.text = self.weatherDetailValues["humidity"]
            
        case WeatherDetailCellTag.sun.rawValue:
            
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
    
    /// Make a request to weather API to get weather data for selected city and display the datas
    func getWeather() {
        
        //Selected city zipcode
        var zip = 0
        //Selected city countrycode
        var countryCode = ""
        
        // Set zip and countryCode variables according to selected city
        switch citySelectionButton.menu?.selectedElements[0].title {
            
        case CityList.lyon.info().name:
            zip = CityList.lyon.info().zipcode
            countryCode = CityList.lyon.info().countryCode
            
        case CityList.newYork.info().name:
            zip = CityList.newYork.info().zipcode
            countryCode = CityList.newYork.info().countryCode
            
        default:
            alert(message: "Couldn't get selected city information before sending request")
            return
        }
        
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
                
                //Request weather data after successfully retrieving selected city coordinates
                self.weatherService.getWeather(lat: lat, lon: lon)  { weather, error in
                    
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

                        //Set UILabels outlets values
                        self.temperature.text = "\(temp)°C"
                        self.weatherDescription.text = "\(description)".capitalized
                        self.min_temp.text = "Min. \(temp_min)°C"
                        self.max_temp.text = "Max. \(temp_max)°C"
                        
                        //Set dictionnary values used by UICollectionViewDataSource protocol
                        self.weatherDetailValues["feels_like"] = "\(feels_like) °C"
                        self.weatherDetailValues["pressure"] = "\(pressure) hPa"
                        self.weatherDetailValues["humidity"] = "\(humidity) %"
                        self.weatherDetailValues["wind_direction"] = "\(self.getDirectionRelativeToPoles(degrees: wind_direction))"
                        self.weatherDetailValues["wind_speed"] = "\(wind_speed) km/h"
                        self.weatherDetailValues["visibility"] = "\(visibility) m"
                        
                        let sunriseHour = self.getFormattedHoursFromTimeStamp(timestamp: sunrise)
                        
                        self.weatherDetailValues["sunrise"] = "Levé: \(sunriseHour)"

                        let sunsetHour = self.getFormattedHoursFromTimeStamp(timestamp: sunset)

                        self.weatherDetailValues["sunset"] = "Couché: \(sunsetHour)"
                        
                        //Reload the view to display the last changes
                        self.weatherDetails.reloadData()
                        
                    }
                }
            }
        }
    }
    
    /// Convert a timestamp to a date and extract its hour section to the format specified
    /// - Parameters:
    ///   - timestamp: Timestamp from wich to extract the hours
    /// - Returns: A string representing a time formatted in french timezone
    func getFormattedHoursFromTimeStamp(timestamp: Int) -> String {

        //Create the date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "FR-fr")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium

        //Convert the timestamp to date object
        let originalDate = Date(timeIntervalSince1970: TimeInterval(timestamp))
        
        //Format the date to french timezone and return a string of it
        let originalDateString = dateFormatter.string(from: originalDate)

        //Slice the formatted date string between date and time and keep only the time
        let hourSequence = originalDateString.components(separatedBy: "à").dropFirst(1)

        guard let hour = hourSequence.first else {
            return "null"
        }

        return hour
    }
    
    /// Match the degree value of wind direction to its earth pole direction counterpart
    /// - Parameter degrees: The degree value of wind direction
    /// - Returns: The wind direction according to earth poles
    func getDirectionRelativeToPoles(degrees: Float) -> String {
        
        if (348.75...360.00).contains(degrees) || (0...11.25).contains(degrees) {
            
            return "N"
        }
        else if (11.25..<33.75).contains(degrees) {
            
            return "NNE"
        }
        else if (33.75..<56.25).contains(degrees) {
            
            return "NE"
        }
        else if (56.25..<78.75).contains(degrees) {
            
            return "ENE"
        }
        else if (78.75..<101.25).contains(degrees) {
            
            return "E"
        }
        else if (101.25..<123.75).contains(degrees) {
            
            return "ESE"
        }
        else if (123.75..<146.25).contains(degrees) {
            
            return "SE"
        }
        else if (146.25..<168.75).contains(degrees) {
            
            return "SSE"
        }
        else if (168.75..<191.25).contains(degrees) {
            
            return "S"
        }
        else if (191.25..<213.75).contains(degrees) {
            
            return "SSW"
        }
        else if (213.75..<236.25).contains(degrees) {
            
            return "SW"
        }
        else if (236.25..<258.75).contains(degrees) {
            
            return "WSW"
        }
        else if (258.75..<281.25).contains(degrees) {
            
            return "W"
        }
        else if (281.25..<303.75).contains(degrees) {
            
            return "WNW"
        }
        else if (303.75..<326.25).contains(degrees) {
            
            return "NW"
        }
        else if (326.25..<348.75).contains(degrees) {
            
            return "NNW"
        }
        else {
            
            return "Null"
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
