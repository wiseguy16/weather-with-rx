//
//  Formatter+ext.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/23/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import Foundation

extension Formatter {

    static let readableDateFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter
    }()
    
    static let readableTimeFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "h a"
        return dateFormatter
    }()
    
}
