import UIKit
import RealmSwift

// MARK: - GroupsJSON
struct GroupsJSON: Codable {
    let response: ResponseGr
}

// MARK: - Response
struct ResponseGr: Codable {
    let count: Int
    let items: [GroupModels]
}

// MARK: - Item
class GroupModels: Object ,Codable {
    @objc dynamic var isMember, id: Int
    @objc dynamic var photo100: String
    @objc dynamic var isAdvertiser, isAdmin: Int
    @objc dynamic var photo50, photo200: String
    let type: TypeEnum
    @objc dynamic var screenName, name: String
    @objc dynamic var isClosed: Int

    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}

enum TypeEnum: String, Codable {
    case group = "group"
    case page = "page"
}
