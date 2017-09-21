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
    open var dispayDateTime: String {
        return DateTransformer.UTCToLocal(date: displayDateTimeUtc)
    }
    open var dispayDateTimeAMPM: String {
        return DateTransformer.UTCToLocalAMPM(date: displayDateTimeUtc)
    }
}
