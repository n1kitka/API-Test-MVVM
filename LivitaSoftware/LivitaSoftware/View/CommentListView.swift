//
//  CommentListView.swift
//  LivitaSoftware
//
//  Created by Никита Савенко on 08.08.2024.
//

import SwiftUI

struct CommentListView: View {
    
    @ObservedObject var viewModel: CommentListViewModel
    
    var body: some View {
        
        NavigationStack {
            VStack {
                List(viewModel.comments ?? [], id: \.id) { comment in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(comment.email ?? "")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.white)
                        
                        Text(comment.body ?? "")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.white.opacity(0.6))
                            .lineLimit(2)
                    }
                }
                
                if viewModel.isLoading {
                    LoaderView()
                }
            }
            .navigationBarTitle("Comments (\(viewModel.comments?.count ?? 0))", displayMode: .inline)
        }
        .task {
            await viewModel.getComments()
        }
    }
}
