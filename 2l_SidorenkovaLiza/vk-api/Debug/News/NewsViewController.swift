//
//  NewsViewController.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 23.12.2021.
//

import UIKit
import Alamofire

import SwiftyJSON

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [NewsModels] = []
    var photoNews: [PhotoNews] = []
    var refreshControl = UIRefreshControl()
    
    var nextFrom = ""
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "cell")
        refreshControl.attributedTitle = NSAttributedString(string: "Идет обновление...")
        refreshControl.addTarget(self, action: Selector(("refresh:")), for: UIControl.Event.valueChanged)
        
        tableView.addSubview(refreshControl)
        self.tableView.isHidden = true
        
        //tableView.prefetchDataSource = self
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
               
               if maxSection > posts.count - 3,
                   !isLoading {
                   isLoading = true

                newsRequest(startFrom: nextFrom)
                   { [weak self] (posts, nextFrom) in
                       guard let self = self else { return }
                    let indexSet = IndexSet(integersIn: self.posts.count ..< self.posts.count + posts.count)
                                   self.news.append(contentsOf: posts)
                                   self.tableView.insertSections(indexSet, with: .automatic)
                                   self.isLoading = false
                               }
                           }
                       }

    }
    
func newsRequest(startFrom: String = "",
                 startTime: Double? = nil,
                 completion: @escaping (Swift.Result<[NewsModels], Error>, String) -> Void) {
      
       let path = "/method/newsfeed.get"
       let params: Parameters = [
           "access_token": Session.shared.token,
           "filters": "post",
           "v": "5.87",
           "count": "20",
           "start_from": startFrom
       ]
      
       if let startTime = startTime {
           params["start_time"] = startTime
       }
      
       AF.request(baseURL + path, method: .get, parameters: params).responseJSON(queue: .global()) { response in
           switch response.result {
           case .failure(let error):
               completion(.failure(error), "")
           case .success(let value):
               let json = JSON(value)
               var friends = [FriendModels]()
               var groups = [GroupModels]()
               let nextFrom = json["response"]["next_from"].stringValue
              
               let parsingGroup = DispatchGroup()
               DispatchQueue.global().async(group: parsingGroup) {
                   friends = json["response"]["profiles"].arrayValue.map { FriendModels(json: $0) }
               }
               DispatchQueue.global().async(group: parsingGroup) {
                groups = json["response"]["groups"].arrayValue.map { GroupModels(json: $0) }
            }
            parsingGroup.notify(queue: .global()) {
                let news = json["response"]["items"].arrayValue.map { NewsModels(json: $0) }
               
                news.forEach { newsItem in
                    if newsItem.sourceId > 0 {
                        let source = friends.first(where: { $0.id == newsItem.sourceId })
                        newsItem.source = source
                    } else {
                        let source = groups.first(where: { $0.id == -newsItem.sourceId })
                        newsItem.source = source
                    }
                }
                DispatchQueue.main.async {
                    completion(.success(news), nextFrom)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        cell.author.text = posts[indexPath.row].postSource.type
        cell.date.text = String(posts[indexPath.row].date)
        cell.likes.text = String(posts[indexPath.row].likes.count)
        cell.comments.text = String(posts[indexPath.row].comments.count)
        cell.postText.text = posts[indexPath.row].text
        cell.postImage.image = UIImage(named: photoNews[indexPath.row].sizes[0].url)
        
        return cell
        
    }

}

