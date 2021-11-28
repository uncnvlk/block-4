//
//  Account.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 18.10.2021.
//

import UIKit

final class Account {
    
    private init() {}
    
    static let shared = Account()
    
    var login: String = ""
    var name: String = ""
}
