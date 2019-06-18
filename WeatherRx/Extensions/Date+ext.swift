//
//  Date+ext.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/24/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import Foundation

extension Date {
    
    var startOfDayInt: Int {
        let startOfDayDate = Calendar.current.startOfDay(for: self)
        return Int(startOfDayDate.timeIntervalSince1970)
    }
    
    var endOfDayInt: Int {
        let startTimeDate = Calendar.current.startOfDay(for: self)
        let endTimeDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: startTimeDate)
        return Int(endTimeDate?.timeIntervalSince1970 ?? 1)
    }
    
}
