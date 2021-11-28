//
//  FriendsDB.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 08.11.2021.
//

import Foundation
import RealmSwift

protocol FriendsDBProtocol {
    func save(_ friend: [FriendModels])
    func load() -> Results<FriendModels>
    func delete(_ friend: FriendModels)
}
final class FriendsDB: FriendsDBProtocol {
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 18)
    }
    
    func save(_ items: [FriendModels]) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(items)
        } 
        print(realm.configuration.fileURL ?? "")
    }
    
    func load() -> Results<FriendModels> {
        let realm = try! Realm()
        let friends: Results<FriendModels> = realm.objects(FriendModels.self)
        print(realm.configuration.fileURL ?? "")
        return friends
    }
    
    func delete(_ items: FriendModels) {
        let realm = try! Realm()
        
        //Асинхронное API
        try! realm.write {
            realm.delete(items)
        }
    }
}
