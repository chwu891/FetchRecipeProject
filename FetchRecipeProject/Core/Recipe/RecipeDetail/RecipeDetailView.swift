//
//  RecipeDetailView.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/15/25.
//

import SwiftUI

struct RecipeDetailView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    
    let cuisine: String
    let name: String
    let photoURLString: String
    let sourceURLString: String
    let youtubeURLString: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                recipePhotoView(photoURLString: photoURLString)
                    .overlay(alignment: .bottomLeading, content: {
                        VStack(spacing: 0) {
                            recipeCuisineView(cuisine: cuisine)
                            recipeNameView(name: name)
                        }
                    })
                
                recipeSourceView(urlString: sourceURLString)
                
                Divider()
                
                recipeVideoView(youtubeURLString: youtubeURLString)
                
                Spacer()
            }
        }
        .ignoresSafeArea()
        .toolbarVisibility(.hidden, for: .navigationBar)
        .background(Color(uiColor: .secondarySystemBackground))
        .overlay(alignment: .topLeading, content: {
            backButton
        })
    }
    
    private var backButton: some View {
        Button {
            onBackButtonPressed()
        } label: {
            Image(systemName: "arrow.left")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(Color.white)
                .fontWeight(.semibold)
                .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private func recipePhotoView(photoURLString: String) -> some View {
        Group {
            if let url = URL(string: photoURLString) {
                ImageLoaderView(url: url)
            } else {
                Image(systemName: "photo")
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .frame(height: UIScreen.main.bounds.width)
    }
    
    private func recipeCuisineView(cuisine: String) -> some View {
        Text(cuisine)
            .foregroundStyle(.white)
            .font(.headline)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius:5))
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func recipeNameView(name: String) -> some View {
        Text(name)
            .foregroundStyle(.white)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(colors: [
                    Color.black.opacity(0),
                    Color.black.opacity(0.3),
                    Color.black.opacity(0.6)
                ], startPoint: .top, endPoint: .bottom)
            )
            .lineLimit(1)
            .minimumScaleFactor(0.3)
    }
    
    @ViewBuilder
    private func recipeSourceView(urlString: String) -> some View {
        if let url = URL(string: urlString) {
            Link("View Full Recipe", destination: url)
                .foregroundColor(.blue)
                .font(.headline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private func recipeVideoView(youtubeURLString: String) -> some View {
        if let videoID = extractYouTubeID(from: youtubeURLString) {
            VStack {
                Text("Watch Recipe Video:")
                    .foregroundStyle(.primary)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                YouTubePlayerView(videoID: videoID)
                    .frame(height: UIScreen.main.bounds.width * 0.7)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal)
        }
    }
    
    func extractYouTubeID(from urlString: String) -> String? {
        if let url = URL(string: urlString),
           let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems,
           let id = queryItems.first(where: { $0.name == "v" })?.value {
            return id
        }
        return nil
    }
    
    func onBackButtonPressed() {
        dismiss()
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(
            cuisine: "Malaysian",
            name: "Apam Balik",
            photoURLString: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
            sourceURLString: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            youtubeURLString: "https://www.youtube.com/watch?v=6R8ffRRJcrg"
        )
    }
}
