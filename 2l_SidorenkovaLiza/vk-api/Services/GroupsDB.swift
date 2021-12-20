//
//  GroupsDB.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 20.12.2021.
//

import Foundation
import RealmSwift

protocol GroupsDBProtocol {
    func save(_ friend: [GroupModels])
    func load() -> Results<GroupModels>
    func delete(_ friend: GroupModels)
}
final class GroupsDB: GroupsDBProtocol {
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 18)
    }
    
    func save(_ items: [GroupModels]) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(items)
        }
        print(realm.configuration.fileURL ?? "")
    }
    
    func load() -> Results<GroupModels> {
        let realm = try! Realm()
        let groups: Results<GroupModels> = realm.objects(GroupModels.self)
        print(realm.configuration.fileURL ?? "")
        return groups
    }
    
    func delete(_ items: GroupModels) {
        let realm = try! Realm()
        
        //Асинхронное API
        try! realm.write {
            realm.delete(items)
        }
    }
}

