//
//  Weather3HrItem.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/23/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import Foundation

struct Weather3HrItem: Codable {
    let cod: String                     // Internal parameter
    let message: Double                 // Internal parameter
    let cnt: Int                        // Number of lines returned by this API call
    let list: [WeatherHourItem]         // See below...
    let city: CityItem                  // See below...
    
}

struct WeatherHourItem: Codable {
    let dt: Int                         // TimeInterval since 1970 UTC
    let main: WeatherConditions         // See below...
    let weather: [WeatherDescription]   // See below...
    let clouds: CloudItem?              // See below...
    let wind: WindItem?                 // See below...
    let dt_txt: String                  // String Date in UTC
    
}

struct WeatherConditions: Codable {
    let temp: Double                    // Degrees Kelvin
    let temp_min: Double                // Degrees Kelvin...
    let temp_max: Double                // Degrees Kelvin...
    let pressure: Double                // Atmospheric pressure on the sea level by default, hPa
    let sea_level: Double?
    let grnd_level: Double?
    let humidity: Int                   // Humidity, %
    let temp_kf: Double?                // Internal parameter
    
    var tempFht: Int {
        return Converter.tempKelvinToFahrenheit(temperature: self.temp)
    }
    var temp_minFht: Int {
        return Converter.tempKelvinToFahrenheit(temperature: self.temp_min)
    }
    var temp_maxFht: Int {
        return Converter.tempKelvinToFahrenheit(temperature: self.temp_max)
    }

}

struct CityItem: Codable {
    let id: Int
    let name: String
    let coord: CoordinateItem?          // See below...
    let country: String?
    let population: Int?
    let timezone: Int?
    
}

struct CoordinateItem: Codable {
    let lat: Double?
    let lon: Double?
    
}

struct WeatherDescription: Codable {
    let id: Int                         // Weather condition id
    let main: String                    // Group of weather parameters (Rain, Snow, Extreme etc.)
    let description: String             // Weather condition within the group
    let icon: String?                   // Weather icon id
    
}

struct CloudItem: Codable {
    let all: Int?                       // Cloudiness, %
    
}

struct WindItem: Codable {
    let speed: Double?                  // Wind speed. Unit Default: meter/sec
    let deg: Double?                    // Wind direction, degrees (meteorological)
    
}
