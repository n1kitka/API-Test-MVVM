//
//  PostModel.swift
//  LivitaSoftware
//
//  Created by Никита Савенко on 08.08.2024.
//

import Foundation

struct PostModel: Codable {
    let id: Int
    let userID: Int?
    let title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

