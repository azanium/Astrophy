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
        let hour = components.hour!
        let minute = components.minute!
        return (hour, minute)
    }
    
    static func UTCToLocalAMPM(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: dt!)
    }

    static func UTCToLocal(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "H:mm"
        
        return dateFormatter.string(from: dt!)
    }

}
