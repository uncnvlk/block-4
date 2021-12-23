//
//  PhotoAPI.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 25.10.2021.
//

import UIKit
import Alamofire


struct Photos {
    
}


final class PhotosAPI {
    
    let baseURL = "https://api.vk.com/method/"
    let token = Session.shared.token
    let userId = Session.shared.userID
    let version = "5.81"
    
    
    
    func getPhotos(completion: @escaping ([Photos])->()) {
        let method = "photos.getAll"
        
        let parameters: Parameters  = [
            "user_id": userId ,
            "access_token": token,
            "v": version,
            "count": 3,
            "extended": 1,
            "photo_sizes": 0
        ]
        
        let url = baseURL + method
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            guard let data = response.data else { return }
            debugPrint(response.data?.prettyJSON)
            

        }
    }

}
