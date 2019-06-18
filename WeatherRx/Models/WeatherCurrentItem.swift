//
//  WeatherCurrentItem.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/25/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import Foundation

struct WeatherCurrentItem: Codable {
    let coord: CoordinateItem           // Reference in Weather3HrItem.swift
    let weather: [WeatherDescription]   // Reference in Weather3HrItem.swift
    let base: String                    // Internal parameter
    let main: WeatherCurrentConditions  // See below
    let visibility: Int?
    let wind: WindItem                  // Reference in Weather3HrItem.swift
    let clouds: CloudItem               // Reference in Weather3HrItem.swift
    let dt: Int                         // TimeInterval since 1970 UTC
    let timezone: Int
    let id: Int                         // City ID
    let name: String                    // City name
    let cod: Int                        // Internal parameter
    
}

struct WeatherCurrentConditions: Codable {
    let temp: Double                    // Degrees Kelvin
    let pressure: Double                // Atmospheric pressure on the sea level by default, hPa
    let humidity: Int                   // Humidity, %
    let temp_min: Double                // Degrees Kelvin...
    let temp_max: Double                // Degrees Kelvin...
    
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
