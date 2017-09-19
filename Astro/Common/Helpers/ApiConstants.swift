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
    
    public static func absoluteUrl(path: String) -> String {
        return (ApiConstants.baseUrl as NSString).appendingPathComponent(path)
    }
    
}