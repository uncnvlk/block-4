//
//  PresentSwift.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 05.12.2021.
//

import Foundation
import UIKit

class PresentFriends: Operation {
    var controllerToPresent: FriendsViewController

    let friendDB = FriendsDB()

    override func main() {
        guard let parsedData = dependencies.first as? ParseData,
        let friends = parsedData.friends else { return }

        let friendsOld = self.friendDB.load()
        friendsOld.forEach {
            friendDB.delete($0)
        }

        self.friendDB.save(friends)
        controllerToPresent.friends = self.friendDB.load()

        controllerToPresent.tableView.reloadData()

        debugPrint("Presenting done")
    }

    init(controller: FriendsViewController) {
        self.controllerToPresent = controller
    }


}
