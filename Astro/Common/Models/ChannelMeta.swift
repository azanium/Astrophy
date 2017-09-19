//
//  ChannelMetaData.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/19/17.
//  Copyright © 2017 Ainasoft. All rights reserved.
//

import Foundation
import RealmSwift

class ChannelMeta: Object {
    
    open dynamic var channelId: String = ""
    open dynamic var siChannelId: String = ""
    open dynamic var channelTitle: String = ""
    open dynamic var channelDescription: String = ""
    open dynamic var channelLanguage: String = ""
    open dynamic var channelCategory: String = ""
    open dynamic var channelStubNumber: String = ""
    open var extRef = List<ChannelExtRef>()
    
    override open static func primaryKey() -> String? {
        return "channelId"
    }
    
    func getDefaultExtRef() -> ChannelExtRef {
        var result = ChannelExtRef()
        
        for ref in extRef {
            if ref.system == "Logo" && ref.subSystem.contains("Neg_600x370") {
                result = ref
                break
            }
        }
        
        return result
    }
}
