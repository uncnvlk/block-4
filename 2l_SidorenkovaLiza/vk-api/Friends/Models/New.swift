import Foundation
import RealmSwift
import SwiftyJSON
import SwiftUI

// MARK: - NewsJSON
//struct Feed: Codable {
// let response: FeedResponse
// 
// init (response: FeedResponse) {
// self.response = response
// }
//}

//MARK: - Response
//struct FeedResponse: Codable {
// let items: [NewsModels]
// let groups: [GroupsNews]
// let profiles: [ProfileModel]
// let nextFrom: String
//
// enum CodingKeys: String, CodingKey {
// case items, groups, profiles
// case nextFrom = "next_from"
// }
//
//}

// MARK: - Group
struct GroupsNews: Codable {
 let id: Int
 let photo100, photo50, photo200: String
 let type, screenName, name: String
 let isClosed: Int

 enum CodingKeys: String, CodingKey {
 case id
 case photo100 = "photo_100"
 case photo50 = "photo_50"
 case photo200 = "photo_200"
 case type
 case screenName = "screen_name"
 case name
 case isClosed = "is_closed"
 }
}

// MARK: - Item
struct NewsModels: Codable {
 let comments: newsComments
 let canSetCategory: Bool
 let likes: newsLikes
 let reposts: NewsReposts
 let type, postType: String
 let date, sourceID: Int
 let text: String
 let canDoubtCategory: Bool
 let attachments: [Attachment]
 let markedAsAds, postID: Int
 let postSource: PostSource
 let views: Views
 
 var someText: Bool {
 return self.text != nil && self.text != ""
 }
 
// var somePhoto: Bool {
// return self.attachments[0].photo?.photoAvailable != nil
// }
 
 var someLink: Bool {
 return self.attachments[0].link?.url != nil
 }
 
 enum CodingKeys: String, CodingKey {
 case comments
 case canSetCategory = "can_set_category"
 case likes, reposts, type
 case postType = "post_type"
 case date
 case sourceID = "source_id"
 case text
 case canDoubtCategory = "can_doubt_category"
 case attachments
 case markedAsAds = "marked_as_ads"
 case postID = "post_id"
 case postSource = "post_source"
 case views
 }
}

// MARK: - Attachment
struct Attachment: Codable {
 let type: String
 let video: Video?
 let photo: PhotoModels?
 let link: Link?
}

struct Link: Codable {
 let title, caption: String
 let url: String
 let linkDescription: String
 let photo: PhotoNews
}

// MARK: - Photo
struct PhotoNews: Codable {
 let albumID, postID, id, date: Int
 let text: String
 let userID: Int
 let sizes: [SizeNews]
 let hasTags: Bool
 let ownerID: Int
 let accessKey: String

 enum CodingKeys: String, CodingKey {
 case albumID = "album_id"
 case postID = "post_id"
 case id, date, text
 case userID = "user_id"
 case sizes
 case hasTags = "has_tags"
 case ownerID = "owner_id"
 case accessKey = "access_key"
 }
}

// MARK: - Size
struct SizeNews: Codable {
 let width, height: Int
 let url: String
 let type: String
 
 
}

// MARK: - Video
struct Video: Codable {
 let firstFrame800: String
 let ownerID, canAdd, duration: Int
 let photo320, photo1280: String
 let firstFrame1280: String
 let title: String
 let views, canLike, canComment: Int
 let firstFrame130: String
 let date: Int
 let firstFrame160: String
 let id, height: Int
 let trackCode: String
 let width, canAddToFaves: Int
 let accessKey: String
 let comments: Int
 let photo800, photo130: String
 let canSubscribe: Int
 let firstFrame320: String
 let canRepost: Int
 let videoDescription: String

 enum CodingKeys: String, CodingKey {
 case firstFrame800 = "first_frame_800"
 case ownerID = "owner_id"
 case canAdd = "can_add"
 case duration
 case photo320 = "photo_320"
 case photo1280 = "photo_1280"
 case firstFrame1280 = "first_frame_1280"
 case title, views
 case canLike = "can_like"
 case canComment = "can_comment"
 case firstFrame130 = "first_frame_130"
 case date
 case firstFrame160 = "first_frame_160"
 case id, height
 case trackCode = "track_code"
 case width
 case canAddToFaves = "can_add_to_faves"
 case accessKey = "access_key"
 case comments
 case photo800 = "photo_800"
 case photo130 = "photo_130"
 case canSubscribe = "can_subscribe"
 case firstFrame320 = "first_frame_320"
 case canRepost = "can_repost"
 case videoDescription = "description"
 }
}

//MARK: - Comments
struct newsComments: Codable {
 let count: Int
}

// MARK: - Likes
struct newsLikes: Codable {
    let count, canLike, userLikes: Int

    enum CodingKeys: String, CodingKey {
    case count
    case canLike = "can_like"
    case userLikes = "user_likes"
    }
   }

   // MARK: - PostSource
   struct PostSource: Codable {
    let type: String
   }

   // MARK: - Reposts
   struct NewsReposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
    case count
    case userReposted = "user_reposted"
    }
   }

   // MARK: - Views
   struct Views: Codable {
    let count: Int
   }

   // MARK: - Profile
   struct ProfileModel: Codable {
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

   // MARK: - OnlineInfo
   struct OnlineInfo: Codable {
    let visible, isMobile, isOnline: Bool

    enum CodingKeys: String, CodingKey {
    case visible
    case isMobile = "is_mobile"
    case isOnline = "is_online"
    }
   }
