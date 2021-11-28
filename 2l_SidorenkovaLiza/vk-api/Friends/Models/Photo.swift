//
//  Photo.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 29.10.2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let photosJSON = try? newJSONDecoder().decode(PhotosJSON.self, from: jsonData)

import Foundation
import RealmSwift

// MARK: - PhotosJSON
struct PhotosJSON: Codable {
    let response: ResponsePh
}

// MARK: - Response
struct ResponsePh: Codable {
    let count: Int
    let items: [PhotoModels]
}

// MARK: - Item
class PhotoModels: Object, Codable {
    @objc dynamic var albumID: Int
    var reposts: Reposts?
    @objc dynamic var postID, id, date: Int
    @objc dynamic var text: String
    var sizes: [Size]
    @objc dynamic var hasTags: Bool
    @objc dynamic var ownerID: Int
    var likes: Likes?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case reposts
        case postID = "post_id"
        case id, date, text, sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case likes
    }
}

// MARK: - Likes
class Likes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
class Reposts: Codable {
    let count: Int
}

// MARK: - Size
class Size: Codable {
    let width, height: Int
    let url: String
    let type: String
}
