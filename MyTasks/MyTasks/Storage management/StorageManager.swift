//
//  StorageManager.swift
//  MyTasks
//
//  Created by Ben Mustafa Anas on 24/02/2021.
//  Copyright © 2021 Ben Mustafa Anas. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ place: Task) {
        
        try! realm.write {
            realm.add(place)
        }
    }
    
    static func deleteObject(_ place: Task) {
        
        try! realm.write {
            realm.delete(place)
        }
    }
}
