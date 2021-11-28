//
//  StorageViewController.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 29.10.2021.
//

import UIKit
import RealmSwift

class User: Object {
    
    // Realm'у нужно следить за данными

    @objc dynamic var userId: String = ""
    @objc dynamic var token: String = ""
    
    
}

class StorageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        useRealm()
    }
    
    func useRealm() {
         
        let user = User()
        user.token = "111123"
        user.userId = "11111"
        
        // solution: падаем, если меняем БД
        let migration = Realm.Configuration(schemaVersion: 2)
        
        // имеем ссылку на хранилище
        let realm = try! Realm(configuration: migration)
        
        // сохранение объекта в Realm
        realm.beginWrite()
        realm.add(user)
        try! realm.commitWrite()
        
        // считание объекта
        let users = realm.objects(User.self)
        
        users.forEach { print ($0.token, $0.userId)  }
    }
}
