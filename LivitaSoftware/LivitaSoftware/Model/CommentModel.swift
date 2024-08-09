//
//  CommentModel.swift
//  LivitaSoftware
//
//  Created by Никита Савенко on 08.08.2024.
//

import Foundation

struct CommentModel: Codable {
    let id: Int
    let postID: Int?
    let name, email, body: String?

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}
