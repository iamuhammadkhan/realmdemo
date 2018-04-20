//
//  Deleted.swift
//  RealmDemo
//
//  Created by MuhammadKhan on 4/20/18.
//  Copyright © 2018 MuhammadKhan. All rights reserved.
//

import RealmSwift

class Deleted: Object {
    
    @objc dynamic var ID = 0
    @objc dynamic var note = ""
    
    override static func primaryKey() -> String? {
        return "ID"
    }
}
