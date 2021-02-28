//
//  PlaceModel.swift
//  MyTasks
//
//  Created by Ben Mustafa Anas on 24/02/2021.
//  Copyright © 2021 Ben Mustafa Anas. All rights reserved.
//

import RealmSwift

class Task: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var status: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var date = Date()
    @objc dynamic var note: String?
    
    convenience init(name: String, status: String?, imageData: Data?, date: Date, note: String?) {
        self.init()
        self.date = date
        self.name = name
        self.status = status
        self.imageData = imageData
        self.note = note
    }
}
