//
//  PostListViewModel.swift
//  LivitaSoftware
//
//  Created by Никита Савенко on 08.08.2024.
//

import Foundation

final class PostListViewModel: ObservableObject {
    
    @Published var posts: [PostModel]?
    @Published var user: UserModel?
    @Published var userError: ApiError?
    @Published var isLoading = false
    
    private let webService: WebService
    
    init(webService: WebService = WebService()) {
        self.webService = webService
    }
    
    @MainActor
    func getPosts(forUserId userId: Int = 1) async {
        isLoading = true
        do {
            let allPosts = try await webService.getPostsData()
            self.posts = allPosts.filter { $0.userID == userId }
            self.isLoading = false
        } catch(let error) {
            userError = ApiError.custom(error: error)
            isLoading = false
        }
    }
    
    func getUser(userId: Int = 1) async {
        isLoading = true
        do {
            self.user = try await webService.getUserData(userId: userId)
            self.isLoading = false
        } catch(let error) {
            userError = ApiError.custom(error: error)
            isLoading = false
        }
    }
}
