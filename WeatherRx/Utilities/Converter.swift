//
//  Converter.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/23/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import Foundation

class Converter {
    
    static func makeDayString(from dateInt: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dateInt))
        return Formatter.readableDateFormat.string(from: date)
    }
    
    static func makeTimeString(from dateInt: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dateInt))
        return Formatter.readableTimeFormat.string(from: date)
    }
    
    static func tempKelvinToFahrenheit(temperature: Double) -> Int {
        let celsiusTemp = temperature - 273.15
        let fahrenheitTemperature = celsiusTemp * 9 / 5 + 32
        return Int(fahrenheitTemperature)
    }
    
    static func speedMetersToMilesPerHr(speed: Double) -> Int {
        return Int((speed / 1609.3) * 3600)
    }
    
    static func pressureHpaToInches(pressure: Double) -> Double {
        return pressure * 0.02953
    }
    
    static func rainMmToInches(precip: Double) -> Double {
        return precip / 25.4
    }
    
    static func getStartOfDayInt(from dateInt: Int) -> Int {
        let date = Date(timeIntervalSince1970: TimeInterval(dateInt))
        return date.startOfDayInt
    }
    
    static func getEndOfDayInt(from dateInt: Int) -> Int {
        let date = Date(timeIntervalSince1970: TimeInterval(dateInt))
        return date.endOfDayInt
    }
    
}
