//
//  File.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/21/17.
//  Copyright © 2017 Ainasoft. All rights reserved.
//

import Foundation

class DateUtils {
    
    static func currentTimeAsString() -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: Date())
        let hour = components.hour!
        let minute = components.minute!
        return String(format: "%02d:%02d", arguments: [hour, minute])
    }
    
    static func currentTime() -> (Int, Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: Date())
        if let hour = components.hour, let minute = components.minute {
            return (hour, minute)
        }
        return (0, 0)
    }
    
    static func UTCToLocalAMPM(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH:mm a"
        
        return dateFormatter.string(from: dt!)
    }

    static func UTCToLocal(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: dt!)
    }
    
    static func durationToMinutes(duration: String, format: String = "HH:mm:ss") -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        var totalDurationInMinutes: Int = 0
        if let dt = dateFormatter.date(from: duration) {
            let calendar = Calendar.current
            
            let components = calendar.dateComponents([.hour, .minute], from: dt)
            
            if let hour = components.hour, let minute = components.minute {
                totalDurationInMinutes = hour * 60 + minute
            }
        }
        
        return totalDurationInMinutes
    }

    static func currentDateForRequest(time: String) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        
        if let year = components.year, let month = components.month, let day = components.day {
            return "\(year)-\(month)-\(day)%20\(time)"
        }
        
        return "2017-09-22%2000:00"
    }
}
