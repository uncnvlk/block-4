//
//  getDataFromURL.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 05.12.2021.
//

import Foundation
import Alamofire

class GetDataFromURL: Operation {
    var outputData: Data?

    override func main() {
        let token = Session.shared.token
        let userId = String(Session.shared.userID)
        let version = "5.81"
        let count = "100"
        let fields = "photo_50, photo_100"
        let order = "name"


        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "user_id", value: userId),
            URLQueryItem(name: "order", value: order),
            URLQueryItem(name: "fields", value: fields),
            URLQueryItem(name: "count", value: count),
            URLQueryItem(name: "v", value: version)
        ]
        guard let url = urlComponents.url else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        self.outputData = data

        debugPrint("Getting data from URL")

    }
}
