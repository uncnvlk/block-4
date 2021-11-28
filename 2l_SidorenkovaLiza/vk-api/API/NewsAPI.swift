
import UIKit
import Alamofire
import SwiftyJSON


final class NewsAPI {
    
    let baseURL = "https://api.vk.com/method/"
    let token = Session.shared.token
    let userId = Session.shared.userID
    let version = "5.81"
    
    let news: [NewModels] = []
    
    
    
    func getNews(completion: @escaping ([NewModels])->()) {
        let method = "newsfeed.get"
        
        let parameters: Parameters  = [
            //"user_id": userId ,
            "filters": "post",
            "access_token": token,
            "v": version,
            "count": 2
        ]
        
        let url = baseURL + method
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            guard let data = response.data else { return }
            debugPrint(response.data?.prettyJSON)
            
            print(response.value)
            
            do {
                let itemsData = try JSON(data)["response"]["items"].rawData()
                let news = try JSONDecoder().decode([NewModels].self, from: itemsData)
                completion(news)
                
            } catch {
                print(error)
                
            }
}
        }
    }

