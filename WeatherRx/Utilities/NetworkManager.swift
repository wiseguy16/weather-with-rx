//
//  NetworkManager.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/23/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import Foundation

enum WeatherMode {
    case current
    case daily
    case hourly
    
    var path: String {
        switch self {
        case .current:
            return "/data/2.5/weather"
        case .daily:
            return "/data/2.5/forecast/daily"
        case .hourly:
            return "/data/2.5/forecast"
        }
    }
    
    var count: String {
        switch self {
        case .current:
            return ""
        case .daily:
            return "7"
        case .hourly:
            return "40"
        }
    }
    
}

class NetworkManager {
    
    private let scheme = "http"
    private let host = "api.openweathermap.org"
    private let kSecretApiKey = "f8fdae74c29544baebdb927d392c5538"
    
    func buildUrl(for city: String, weatherMode: WeatherMode) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = weatherMode.path
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "unit", value: "metric"),
            URLQueryItem(name: "cnt", value: weatherMode.count),
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "appid", value: kSecretApiKey)
        ]
        
        return components.url
    }
    
}
