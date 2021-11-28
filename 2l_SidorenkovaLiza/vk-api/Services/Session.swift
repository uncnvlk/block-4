//
//  Session.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 24.10.2021.
//

import Foundation

final class Session {
    
    private init() {}
    
    static let shared = Session() 
    
    var token = ""
    var userID = ""
}
