//
//  WebService.swift
//  LivitaSoftware
//
//  Created by Никита Савенко on 08.08.2024.
//

import Foundation

final class WebService {
    
    // MARK: - Network Request Helper
    
    private func fetchData<T: Decodable>(from urlString: String, responseType: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw ApiError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw ApiError.invalidData
        }
    }
    
    // MARK: - Public API Methods
    
    func getPostsData() async throws -> [PostModel] {
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        return try await fetchData(from: urlString, responseType: [PostModel].self)
    }
    
    func getCommentsData(postId: Int) async throws -> [CommentModel] {
        let urlString = "https://jsonplaceholder.typicode.com/comments?postId=\(postId)"
        return try await fetchData(from: urlString, responseType: [CommentModel].self)
    }
    
    func getUserData(userId: Int) async throws -> UserModel {
        let urlString = "https://jsonplaceholder.typicode.com/users/\(userId)"
        return try await fetchData(from: urlString, responseType: UserModel.self)
    }
}

