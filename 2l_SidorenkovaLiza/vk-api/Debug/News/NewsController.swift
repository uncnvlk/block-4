//
//  NewsController.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 25.09.2021.
//

import UIKit
import Alamofire
import Realm


class NewsController: UIViewController {

    
    @IBOutlet weak var NewsTableView: UITableView!
    
    
    private let newsService = NewsAPI()
    
    
    private var news: [NewModels] = []
    private var groups: [GroupsNews] = []
    private var profiles: [ProfileModels] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NewsTableView.register(R.Nib.newText, forCellReuseIdentifier: R.Cell.newText)
        self.NewsTableView.register(R.Nib.newImage, forCellReuseIdentifier: R.Cell.newImage)
        self.NewsTableView.register(R.Nib.newAuthorandDate, forCellReuseIdentifier: R.Cell.newAuthorandDate)
        self.NewsTableView.register(R.Nib.newLikesandComments, forCellReuseIdentifier: R.Cell.newLikesandComments)
        
        newsService.getNews { [weak self] news, groups, profiles in
            guard let self = self else {return}

//            self.feeds = feeds
            self.news = news
            self.groups = groups
            self.profiles = profiles

            self.NewsTableView.reloadData()
        }
    }
}

extension NewsController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {

                case 0: return tableView.dequeueReusableCell(withIdentifier: R.Cell.newText, for: indexPath)
                case 1: return tableView.dequeueReusableCell(withIdentifier: R.Cell.newImage, for: indexPath)
                case 2: return tableView.dequeueReusableCell(withIdentifier: R.Cell.newAuthorandDate, for: indexPath)
                case 3: return tableView.dequeueReusableCell(withIdentifier: R.Cell.newLikesandComments, for: indexPath)
                default:
                    return tableView.dequeueReusableCell(withIdentifier: R.Cell.newText, for: indexPath)
                }
    }
}

extension NewsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.news.count == 0 {
                    (cell as? NewTextTableViewCell)?.configure(postTextFromVK: "test")
                    } else {
                        (cell as? NewTextTableViewCell)?.configure(postTextFromVK: self.news[0].text)
                        }
                (cell as? NewImageTableViewCell)?.configure(postImageFromVK: "123")
                (cell as? NewAuthorandDateTableViewCell)?.configure(authorPhotoFromVK: "000", authorNameFromVK: "lisa", postDateFromVK: "dd.mm.yy")
                (cell as? NewLikesandCommentsTableViewCell)?.configure(likesFromVK: "3", commentsFromVK: "20")
                }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}
