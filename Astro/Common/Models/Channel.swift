//
//  Channel.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/19/17.
//  Copyright © 2017 Ainasoft. All rights reserved.
//

import Foundation
import RealmSwift

open class Channel: Object {
    
    open dynamic var id: Int = 0
    open dynamic var title: String = ""
    open dynamic var stubNumber: Int = 0
    
    override open static func primaryKey() -> String? {
        return "id"
    }
    
    // Specify properties to ignore (Realm won't persist these)
    
    //override static func ignoredProperties() -> [String] {
    //  return []
    //}
}
