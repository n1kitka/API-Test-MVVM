//
//  CommentListViewModel.swift
//  LivitaSoftware
//
//  Created by Никита Савенко on 08.08.2024.
//

import Foundation

final class CommentListViewModel: ObservableObject {
    
    @Published var comments: [CommentModel]?
    @Published var userError: ApiError?
    @Published var isLoading = false
    
    private let webService: WebService
    private let postId: Int
    
    init(postId: Int, webService: WebService = WebService()) {
        self.webService = webService
        self.postId = postId
    }
    
    @MainActor
    func getComments() async {
        isLoading = true
        do {
            self.comments = try await webService.getCommentsData(postId: postId)
            self.isLoading = false
        } catch(let error) {
            userError = ApiError.custom(error: error)
            isLoading = false
        }
    }
}
