
import UIKit
import Alamofire
import SwiftyJSON


final class NewsAPI {
    
    let baseURL = "https://api.vk.com/method/"
    let token = Session.shared.token
    let userId = Session.shared.userID
    let version = "5.81"
    
    let news: [NewModels] = []
    
    
    
    func getNews(completion: @escaping ([NewModels],[GroupsNews], [ProfileModels])->()) {
        let method = "newsfeed.get"
        
        let parameters: Parameters  = [
            //"user_id": userId ,
            "filters": "post",
            "access_token": token,
            "v": version,
            "count": 2
        ]
        
        let url = baseURL + method
        AF.request(url, method: .get, parameters: parameters).responseJSON  { response in
                    
                    guard let data = response.data else { return }
                    
                    let decoder = JSONDecoder()
                    let json = JSON(data)
                    let dispatchGroup = DispatchGroup()
                    
                    let vkNewsJSONArr = json["response"]["items"].arrayValue
                    let vkProfilesJSONArr = json["response"]["profiles"].arrayValue
                    let vkGroupsJSONArr = json["response"]["groups"].arrayValue
                    
                    var vkNewsArray: [NewModels] = []
                    var vkProfilesArray: [ProfileModels] = []
                    var vkGroupsArray: [GroupsNews] = []
                    
                    //News
                    DispatchQueue.global().async(group: dispatchGroup) {
                        
                        for (index, items) in vkNewsJSONArr.enumerated() {
                            
                            do {

                                let decodedItem = try decoder.decode(NewModels.self, from: items.rawData())
                                vkNewsArray.append(decodedItem)
                                
                            } catch (let errorDecode) {
                                print("index: \(index), error: \(errorDecode)")
                            }
                        }
                    }
                    
                    //Profiles
                    DispatchQueue.global().async(group: dispatchGroup) {
                        
                        for (index, profiles) in vkProfilesJSONArr.enumerated() {
                            
                            do {

                                let decodedItem = try decoder.decode(ProfileModels.self, from: profiles.rawData())
                                vkProfilesArray.append(decodedItem)
                                
                            } catch (let errorDecode) {
                                print("index: \(index), error: \(errorDecode)")
                            }
                        }
                    }
                    
                    //Groups
                    DispatchQueue.global().async(group: dispatchGroup) {
                        
                        for (index, groups) in vkGroupsJSONArr.enumerated() {
                            
                            do {

                                let decodedItem = try decoder.decode(GroupsNews.self, from: groups.rawData())
                                vkGroupsArray.append(decodedItem)
                                
                            } catch (let errorDecode) {
                                print("index: \(index), error: \(errorDecode)")
                            }
                        }
                    }
                    
                    dispatchGroup.notify(queue: DispatchQueue.main) {

                        completion(vkNewsArray, vkGroupsArray, vkProfilesArray)
                    }
                    
                }
        }
    }

