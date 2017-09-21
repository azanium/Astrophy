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
    
    func importChannels(channels: [Channel], rowsPerPage: Int = 10) {
        let totalPage = Int(ceil(Double(channels.count) / Double(rowsPerPage)))
        
        self.rowsPerPage = rowsPerPage
        self.pageCount = totalPage
        
        print("Channels totalPage: \(totalPage)")
        
        guard channels.count > 0 else {
            return
        }
        
        pages.removeAll()
        
        let chunks = channels.chunks(rowsPerPage)
        for chunk in chunks {
            var page = Page()
            for ch in chunk {
                page.channels += [String(ch.id)]
            }
            pages += [page]
        }
    }
}

struct Page {
    var channels = [String]()
    var channelIds: String {
        return channels.joined(separator: ",")
    }
}
