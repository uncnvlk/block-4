//
//  NewsViewController.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 23.12.2021.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        <#code#>
    }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var posts: [NewsModels] = []
    var photoNews: [PhotoNews] = []
    var refreshControl = UIRefreshControl()
    
    var loadMoreStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "cell")
        refreshControl.attributedTitle = NSAttributedString(string: "Идет обновление...")
        refreshControl.addTarget(self, action: Selector(("refresh:")), for: UIControl.Event.valueChanged)
        
        tableView.addSubview(refreshControl)
        self.tableView.isHidden = true
        
        //tableView.prefetchDataSource = self
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
