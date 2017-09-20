//
//  DataTransformer.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/20/17.
//  Copyright © 2017 Ainasoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class DataTransformer {
    
    static func transformJsonToChannels(_ json: JSON) -> [Channel] {
        
        var channels = [Channel]()
        
        if let channelJsonArray = json["channels"].array {
            
            for channelJson in channelJsonArray {
                
                let channel = Channel()
                if let channelId = channelJson["channelId"].int {
                    channel.id = channelId
                }
                
                if let channelTitle = channelJson["channelTitle"].string {
                    channel.title = channelTitle
                }
                
                if let channelStubNumber = channelJson["channelStbNumber"].int {
                    channel.stubNumber = channelStubNumber
                }
                
                channels += [channel]
            }
        }
        
        return channels
    }
    
    static func transformJsonToChannelMeta(_ json: JSON) -> [ChannelMeta] {
        
        var channels = [ChannelMeta]()
        
        if let channelJsonArray = json["channel"].array {
            
            for channelJson in channelJsonArray {
                
                let meta = ChannelMeta()
                if let channelId = channelJson["channelId"].int {
                    meta.channelId = String(channelId)
                }
                
                if let siChannelId = channelJson["siChannelId"].string {
                    meta.siChannelId = siChannelId
                }
                
                if let channelTitle = channelJson["channelTitle"].string {
                    meta.channelTitle = channelTitle
                }
                
                if let channelDescription = channelJson["channelDescription"].string {
                    meta.channelDescription = channelDescription
                }
                
                if let channelLanguage = channelJson["channelLanguage"].string {
                    meta.channelLanguage = channelLanguage
                }
                
                if let channelCategory = channelJson["channelCategory"].string {
                    meta.channelCategory = channelCategory
                }
                
                if let channelStubNumber = channelJson["channelStbNumber"].string {
                    meta.channelStubNumber = channelStubNumber
                }
                
                if let extRefArray = channelJson["channelExtRef"].array {
                    
                    for extRefJson in extRefArray {
                        
                        let extRef = ChannelExtRef()
                        
                        if let system = extRefJson["system"].string {
                            extRef.system = system
                        }
                        
                        if let subSystem = extRefJson["subSystem"].string {
                            extRef.subSystem = subSystem
                        }
                        
                        if let value = extRefJson["value"].string {
                            extRef.value = value
                        }
                        
                        meta.extRef += [extRef]
                        
                    }
                }
                meta.defaultLogo = meta.getDefaultExtRef().value
                channels += [meta]
            }
        }
        
        
        
        return channels
    }
}
