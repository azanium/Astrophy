//
//  ApiConstants.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/19/17.
//  Copyright © 2017 Ainasoft. All rights reserved.
//

import Foundation

class ApiConstants: NSObject {
    static let baseUrl = "http://ams-api.astro.com.my"
    
    static let channelList = "/ams/v3/getChannelList"
    static let channelMetas = "/ams/v3/getChannels"
    static let channelEvents = "/ams/v3/getEvents"
    
    public static func absoluteUrl(path: String) -> String {
        return (ApiConstants.baseUrl as NSString).appendingPathComponent(path)
    }
    
}

class ApiResponse {
    
    enum ChannelsResponse {
        case success(channels: [Channel])
        case error(message: String)
    }
    
    enum ChannelMetaResponse {
        case success(channels: [ChannelMeta])
        case error(message: String)
    }
    
    enum ChannelEventsResponse {
        case success(events: [ChannelEvent])
        case error(message: String)
    }
}
