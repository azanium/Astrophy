//
//  ChannelEvent.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/21/17.
//Copyright © 2017 Ainasoft. All rights reserved.
//

import Foundation
import RealmSwift

open class ChannelEvent: Object {
    open dynamic var channelId: String = ""
    open dynamic var programmeTitle: String = ""
    open dynamic var displayDateTimeUtc: String = ""
    open var displayDateTime: String {
        return DateUtils.UTCToLocal(date: displayDateTimeUtc)
    }
    open var displayDateTimeAMPM: String {
        return DateUtils.UTCToLocalAMPM(date: displayDateTimeUtc)
    }
    open var displayDateTimeInMinutes: Int {
        return DateUtils.durationToMinutes(duration: displayDateTime, format: "HH:mm")
    }
    
    open dynamic var displayDuration: String = ""
    open var displayDurationInMinutes: Int {
        return DateUtils.durationToMinutes(duration: displayDuration)
    }
}
