//
//  RecipeDetailView.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/15/25.
//

import SwiftUI

import SwiftUI

@MainActor
class RecipeDetailViewModel: ObservableObject {
    
}

struct RecipeDetailView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                recipePhotoView(photoURLString: recipe.photoURLLarge)
                    .overlay(alignment: .bottomLeading, content: {
                        VStack(spacing: 0) {
                            recipeCuisineView(cuisine: recipe.cuisine)
                            recipeNameView(name: recipe.name)
                        }
                    })
                
                recipeSourceView(sourceURLString: recipe.sourceURL)
                
                Divider()
                
                recipeVideoView(youtubeURLString: recipe.youtubeURL)
                
                Spacer()
            }
        }
        .ignoresSafeArea()
        .toolbar(.hidden, for: .navigationBar)
        .background(Color(uiColor: .secondarySystemBackground))
        .overlay(alignment: .topLeading, content: {
            backButton
        })
    }
    
    private var backButton: some View {
        Button {
            dismiss()
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
    private func recipePhotoView(photoURLString: String?) -> some View {
        Group {
            if let urlString = photoURLString,
               let url = URL(string: urlString) {
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
    private func recipeSourceView(sourceURLString: String?) -> some View {
        if let urlString = sourceURLString,
           let url = URL(string: urlString) {
            Link("View Full Recipe", destination: url)
                .foregroundColor(.blue)
                .font(.headline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder
    private func recipeVideoView(youtubeURLString: String?) -> some View {
        if let urlString = youtubeURLString,
           let videoID = extractYouTubeID(from: urlString),
           let thumbnailURL = URL(string: "https://img.youtube.com/vi/\(videoID)/hqdefault.jpg"),
           let videoURL = URL(string: "https://www.youtube.com/watch?v=\(videoID)") {
            
            let horizontalPadding: CGFloat = 20
            let fullWidth = UIScreen.main.bounds.width
            let imageWidth = fullWidth - (horizontalPadding * 2)
            let imageHeight = imageWidth * 9 / 16
            
            VStack {
                Text("Watch Recipe Video:")
                    .foregroundStyle(.primary)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Link(destination: videoURL) {
                    ZStack {
                        ImageLoaderView(url: thumbnailURL)
                            .frame(width: imageWidth, height: imageHeight)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .shadow(radius: 4)
                    }
                }
            }
            .padding(.horizontal, horizontalPadding)
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
}

#Preview {
    NavigationStack {
        RecipeDetailView(recipe: Recipe.mock)
    }
}
