//
//  GroupAPI.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 25.10.2021.
//

import UIKit
import Alamofire


final class GroupsAPI {
    
    let baseURL = "https://api.vk.com/method/"
    let token = Session.shared.token
    let userId = Session.shared.userID
    let version = "5.81"
    
    func getGroups(completion: @escaping ([GroupModels])->()) {
        let method = "groups.get"
        
        let parameters: Parameters  = [
            "user_id": userId ,
            "access_token": token,
            "v": version,
            "extended": 1
        ]
        
        let url = baseURL + method
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            guard let data = response.data else { return }
            //debugPrint(response.data?.prettyJSON)
        
            do {
                
                let groupsJSON = try JSONDecoder().decode(GroupsJSON.self, from: data)
                
                let groups = groupsJSON.response.items
                completion(groups)
                
            } catch {
                print(error)
            }
        }
    }
    
    func getSearchGroup(completion: @escaping ([GroupModels])->()) {
        let method = "group.search"
        
        let parameters: Parameters  = [
            "user_id": userId ,
            "access_token": token,
            "v": version,
            "q": "MeMeBlog"
        ]
        
        let url = baseURL + method
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response.value)
        }
    }

    
    

}
