//
//  ImageLoaderView.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/14/25.
//

import SwiftUI

struct ImageLoaderView: View {
    
    let url: URL
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    ImageLoaderView(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")!)
        .frame(width: 50, height: 50)
}
