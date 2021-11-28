import UIKit
import RealmSwift

// MARK: - FriendsJSON
struct FriendsJSON: Codable {
    let response: ResponseFr
}

// MARK: - Response
struct ResponseFr: Codable {
    let count: Int
    let items: [FriendModels]
}

// MARK: - Item

// Realm(), class
class FriendModels: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var lastName: String
    @objc dynamic var photo50: String
    @objc dynamic var trackCode, firstName: String
    @objc dynamic var photo100: String

    @objc dynamic var fullName: String {
        firstName + " " + lastName
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
        case trackCode = "track_code"
        case firstName = "first_name"
        case photo100 = "photo_100"
    }
}
