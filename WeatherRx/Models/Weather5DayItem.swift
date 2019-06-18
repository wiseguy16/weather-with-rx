//
//  Weather5DayItem.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/23/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import Foundation

struct Weather5DayItem: Codable {
    let cod: String                     // Internal parameter
    let message: Double                 // Internal parameter
    let cnt: Int                        // Number of lines returned by this API call
    let list: [WeatherDailyItem]        // See below...
    let city: CityItem                  // Reference in Weather3HrItem.swift
    
}

struct WeatherDailyItem: Codable {
    let dt: Int                         // Time of data forecasted
    let temp: TemperatureItem           // See below...
    let pressure: Double                // Atmospheric pressure on the sea level, hPa
    let humidity: Int                   // Humidity, %
    let weather: [WeatherDescription]   // Reference in Weather3HrItem.swift
    let speed: Double?                  // Wind speed. Unit Default: meter/sec
    let deg: Int?                       // Wind direction, degrees (meteorological)
    let clouds: Int?                    // Cloudiness, %
    let rain: Double?                   // Precipitation volume, mm
    
}

struct TemperatureItem: Codable {
    let day: Double                     // Day temperature. Unit Default: Kelvin,
    let min: Double                     // Min daily temperature.
    let max: Double                     // Max daily temperature.
    let night: Double                   // Night temperature.
    let eve: Double                     // Evening temperature.
    let morn: Double                    // Morning temperature.
    
    var dayFht: Int {
        return Converter.tempKelvinToFahrenheit(temperature: self.day)
    }
    var minFht: Int {
        return Converter.tempKelvinToFahrenheit(temperature: self.min)
    }
    var maxFht: Int {
        return Converter.tempKelvinToFahrenheit(temperature: self.max)
    }
    var nightFht: Int {
        return Converter.tempKelvinToFahrenheit(temperature: self.night)
    }
    var eveFht: Int {
        return Converter.tempKelvinToFahrenheit(temperature: self.eve)
    }
    var mornFht: Int {
        return Converter.tempKelvinToFahrenheit(temperature: self.morn)
    }
    
}
