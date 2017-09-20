//
//  Preferences.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/20/17.
//  Copyright © 2017 Ainasoft. All rights reserved.
//

import Foundation
import RealmSwift

open class Preferences: Object {
    
    static let uuid = "user"
    open dynamic var uniqueId = Preferences.uuid
    
    open var favorites = List<ChannelMeta>()
    open var sortChannelNameAscending: Bool = false
    open var sortChannelNumberAscending: Bool = false
    open var sortFavoriteNameAscending: Bool = false
    open var sortFavoriteNameDescending: Bool = false
    open var email: String = ""
    
    override open static func primaryKey() -> String? {
        return "uniqueId"
    }
    
    open func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self, update: true)
            }
        }
        catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    open func getFavoriteIndex(of: ChannelMeta) -> Int {
        
        var index = 0
        for fav in favorites {
            
            print("fav: \(fav.channelId), of: \(of.channelId)")
            if fav.channelId == of.channelId {
                return index
            }
            index += 1
        }
        
        return -1
    }
    
    open func cloneFavorites() -> List<ChannelMeta> {
        let results = List<ChannelMeta>()
        
        results.append(objectsIn: favorites)
        
        return results
    }
    
    open static func getPreferences() -> Preferences {
        do {
            let realm = try Realm()
            if let pref = realm.object(ofType: Preferences.self, forPrimaryKey: Preferences.uuid) {
                return pref
            }
        }
        catch let error as NSError {
            fatalError(error.localizedDescription)
        }
        return Preferences()
    }
    
    open static func write(block: (() -> Void)) {
        do {
            let realm = try Realm()
            try realm.write(block)
        }
        catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
}
