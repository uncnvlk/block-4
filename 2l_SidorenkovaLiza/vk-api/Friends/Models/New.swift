// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:

import Foundation


// MARK: - Group
struct GroupsNews: Codable {
    let isMember, id: Int
    let photo100: String
    let isAdvertiser, isAdmin: Int
    let photo50, photo200: String
    let type, screenName, name: String
    let isClosed: Int

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

// MARK: - Item
struct NewModels: Codable {
    //let comments: Comments
    let canSetCategory: Bool
    //let likes: Likes
    //let reposts: Comments
    let type, postType: String
    let date, sourceID: Int
    let text: String
    let canDoubtCategory: Bool
    //let attachments: [Attachment]
    let markedAsAds, postID: Int
    //let views: Comments

    enum CodingKeys: String, CodingKey {
        //case comments
        case canSetCategory = "can_set_category"
        case type
        case postType = "post_type"
        case date
        case sourceID = "source_id"
        case text
        case canDoubtCategory = "can_doubt_category"
        //case attachments
        case markedAsAds = "marked_as_ads"
        case postID = "post_id"
        //case views
    }
}


//// MARK: - Profile
struct ProfileModels: Codable {
    let online, id: Int
    let photo100: String
    let lastName: String
    let photo50: String
    let onlineInfo: OnlineInfo
    let sex: Int
    let screenName, firstName: String

    enum CodingKeys: String, CodingKey {
        case online, id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case onlineInfo = "online_info"
        case sex
        case screenName = "screen_name"
        case firstName = "first_name"
    }
}
//
//// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible, isMobile, isOnline: Bool

    enum CodingKeys: String, CodingKey {
        case visible
        case isMobile = "is_mobile"
        case isOnline = "is_online"
    }
}
