//
//  FriendsViewController.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 16.09.2021.
//

import UIKit
import RealmSwift

class FriendsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchController: UISearchController!
    
    
    var SearchFriendItem: [FriendModels] = []
    
    let friendsService = FriendsAPI()
    let photosService = PhotosAPI()
    let groupsService = GroupsAPI()
    
    let friendsDB = FriendsDB()
    
    //var friends: Results<FriendModels>?
    var friends: Results<FriendModels>?
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(R.Nib.basic, forCellReuseIdentifier: R.Cell.basic)
        //self.getData()
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        
        //Operation queue results
        let operationsQueue = OperationQueue.main
        let getFriends = GetDataFromURL()
        let parseFriends = ParseData()
        let showFriends = PresentFriends(controller: self)

        parseFriends.addDependency(getFriends)
        showFriends.addDependency(parseFriends)

        let operations = [getFriends, parseFriends, showFriends]
        operationsQueue.addOperations(operations, waitUntilFinished: false)
    }
}
    

extension FriendsViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
                    return SearchFriendItem.count
                } else {
                    guard friends != nil else {return 0}
                    return self.friends!.count
                }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return tableView.dequeueReusableCell(withIdentifier: R.Cell.basic, for: indexPath)
    }
    
    
}

extension FriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if searchController.isActive {
                    (cell as? BasicTableViewCell)?.configure(with: self.SearchFriendItem[indexPath.row])
                } else {
                    (cell as? BasicTableViewCell)?.configure(with: self.friends![indexPath.row])
                }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            if searchController.isActive {
                return false
            } else {
                return true
            }
}
}

extension FriendsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
            if let searchText = searchController.searchBar.text {
                filterContent(searchText: searchText)
                tableView.reloadData()
            }
        }
        func filterContent(searchText: String){
            SearchFriendItem = friends!.filter({(FriendsSome: FriendModels) -> Bool in
                let nameMatch = FriendsSome.fullName.range(of: searchText)
                return nameMatch != nil
            })
        }
}
