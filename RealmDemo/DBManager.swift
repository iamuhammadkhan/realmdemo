//
//  DBManager.swift
//  RealmDemo
//
//  Created by MuhammadKhan on 4/20/18.
//  Copyright © 2018 MuhammadKhan. All rights reserved.
//

import UIKit
import RealmSwift

class DBManager {
    
    private var   database:Realm
    static let   shared = DBManager()
    private init() {
        database = try! Realm()
    }
    
    func getItemsFromDB() -> Results<Item> {
        let results: Results<Item> =   database.objects(Item.self)
        return results
    }
    
    func addItem(object: Item)   {
        try! database.write {
            database.add(object, update: true)
            print("Added new object")
        }
    }
    
    func deleteAllFromDatabase()  {
        try! database.write {
            database.deleteAll()
        }
    }
    
    func deleteItemFromDb(object: Item)   {
        try! database.write {
            database.delete(object)
        }
    }
    
    func getCompletedFromDB() -> Results<Completed> {
        let results: Results<Completed> =   database.objects(Completed.self)
        return results
    }
    
    func addCompleted(object: Completed)   {
        try! database.write {
            database.add(object, update: true)
            print("Added new object")
        }
    }
    
    func deleteCompletedFromDb(object: Completed)   {
        try! database.write {
            database.delete(object)
        }
    }
    
    func getDeletedFromDB() -> Results<Deleted> {
        let results: Results<Deleted> =   database.objects(Deleted.self)
        return results
    }
    
    func addDeleted(object: Deleted)   {
        try! database.write {
            database.add(object, update: true)
            print("Added new object")
        }
    }
    
    func deleteDeletedFromDb(object: Deleted)   {
        try! database.write {
            database.delete(object)
        }
    }
}
