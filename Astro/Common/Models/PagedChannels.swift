//
//  PagedChannels.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/20/17.
//  Copyright © 2017 Ainasoft. All rights reserved.
//

import Foundation

class PagedChannels {
    var currentPage: Int = 1
    var pageCount: Int = 0
    var rowsPerPage: Int = 10
    var pages = [Page]()
    
    func importChannels(channels: [ChannelMeta], rowsPerPage: Int = 10) {
        self.rowsPerPage = rowsPerPage
        
    }
}

struct Page {
    var channels = [String]()
}
