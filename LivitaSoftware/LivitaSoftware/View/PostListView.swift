//
//  ContentView.swift
//  LivitaSoftware
//
//  Created by Никита Савенко on 08.08.2024.
//

import SwiftUI

struct PostListView: View {
    
    @ObservedObject var viewModel = PostListViewModel()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                List(viewModel.posts ?? [], id: \.id) { post in
                    NavigationLink(destination: CommentListView(viewModel: CommentListViewModel(postId: post.id))) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(post.title ?? "")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.white)
                                .lineLimit(1)
                            
                            Text(post.body ?? "")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.white.opacity(0.6))
                                .lineLimit(2)
                        }
                    }
                }
                .listStyle(.grouped)
                .listRowInsets(EdgeInsets())
                
                if viewModel.isLoading {
                    LoaderView()
                }
            }
            .navigationBarTitle(viewModel.user?.name ?? "Loading...", displayMode: .inline)
        }
        .task {
            await viewModel.getUser()
            await viewModel.getPosts(forUserId: 1)
        }
    }
}

#Preview {
    PostListView()
}
