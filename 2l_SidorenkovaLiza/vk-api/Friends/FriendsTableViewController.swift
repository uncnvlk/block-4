//
//  FriendsTableViewController.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 24.10.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    private var searchController: UISearchController!
    
    let friendsService = FriendsAPI()
    let photosService = PhotosAPI()
    let groupsService = GroupsAPI()

    var friends: [FriendModels] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        friendsService.getFriends{ [weak self] friends in
            self?.friends = friends
            self?.tableView.reloadData()
        }
        
        searchController = UISearchController(searchResultsController: nil)
                tableView.tableHeaderView = searchController.searchBar
                searchController.searchResultsUpdater = self
        
        
        
//        photosService.getPhotos { photos in
//            print("Получили фото в контроллере")
//        }
        
        /*groupsService.getGroup { groups in
            print("Получили список групп в контроллере")
        }
        
        
        groupsService.getSearchGroup { searchGroups in
            print("Получили поиск группы в контроллере")
        }*/
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let friend = friends[indexPath.row]
        
        cell.textLabel?.text = friend.fullName
        
        return cell
    }


}

extension FriendsTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if searchController.isActive {
                    (cell as? BasicTableViewCell)?.configure(with: self.SearchFriendItem[indexPath.row])
                } else {
                    (cell as? BasicTableViewCell)?.configure(with: self.friends[indexPath.row])
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

extension FriendsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
            if let searchText = searchController.searchBar.text {
                filterContent(searchText: searchText)
                tableView.reloadData()
            }
        }
        func filterContent(searchText: String){
            SearchFriendItem = FriendItem.filter({(FriendsSome: FriendsDisplayItem) -> Bool in
                let nameMatch = FriendsSome.friend.range(of: searchText)
                return nameMatch != nil
            })
        }
}
