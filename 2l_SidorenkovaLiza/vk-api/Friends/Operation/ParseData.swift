//
//  ParseData.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 05.12.2021.
//

import Foundation
import SwiftyJSON

class ParseData: Operation {
    var friends: [FriendModels]? = []

    override func main() {
        guard let friendsData = dependencies.first as? GetDataFromURL,
              let data = friendsData.outputData else { return }

        do {
            let itemsData = try JSON(data)["response"]["items"].rawData()
            self.friends = try JSONDecoder().decode([FriendModels].self, from: itemsData)

        } catch {
            debugPrint(error)
        }

        debugPrint("pars")

    }

}
