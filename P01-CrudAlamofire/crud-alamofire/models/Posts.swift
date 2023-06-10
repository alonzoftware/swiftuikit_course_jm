//
//  Posts.swift
//  crud-alamofire
//
//  Created by Rene Alonzo Choque Saire on 31/5/23.
//

import Foundation
struct Post: Codable {
    let id : String
    let title : String
    let content : String
    let image_url : String
    let image_name : String
}

//import Foundation
//   let posts = try? newJSONDecoder().decode(Posts.self, from: jsonData)

// MARK: - Posts
//struct Posts: Codable {
//    let total: Int
//    let posts: [Post]
//}

// Post.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let post = try? newJSONDecoder().decode(Post.self, from: jsonData)

// MARK: - Post
//struct Post: Codable {
//    let id, title, content: String
//    let imageURL: String
//    let imageName: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, title, content
//        case imageURL
//        case imageName
//    }
//}
