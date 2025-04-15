//
//  RecipeCellView.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/14/25.
//

import SwiftUI

struct RecipeCellView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let cuisine: String
    let name: String
    let photoURLString: String
    let sourceURLString: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            HStack(alignment: .top, spacing: 10) {
                recipePhotoView(photoURLString: photoURLString)
                
                VStack(alignment: .leading, spacing: 5) {
                    recipeCuisineView(cuisine: cuisine)
                    
                    recipeNameView(name: name)
                    
                    recipeSourceView(urlString: sourceURLString)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            chevronRightImage
        }
        .padding()
        .background(colorScheme == .dark ? Color(uiColor: .secondarySystemBackground) : Color(uiColor: .secondarySystemBackground))
        .mask(RoundedRectangle(cornerRadius: 10))
    }
    
    @ViewBuilder
    private func recipePhotoView(photoURLString: String) -> some View {
        if let url = URL(string: photoURLString) {
            ImageLoaderView(url: url)
                .frame(width: 75, height: 75)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        } else {
            Image(systemName: "photo")
                .frame(width: 75, height: 75)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    private func recipeCuisineView(cuisine: String) -> some View {
        Text(cuisine)
            .foregroundStyle(colorScheme == .dark ? .black : .white)
            .font(.caption)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(colorScheme == .dark ? .gray : .black)
            .clipShape(RoundedRectangle(cornerRadius:5))
    }
    
    private func recipeNameView(name: String) -> some View {
        Text(name)
            .foregroundStyle(.primary)
            .font(.headline)
    }
    
    @ViewBuilder
    private func recipeSourceView(urlString: String) -> some View {
        if let url = URL(string: urlString) {
            Link("View Recipe", destination: url)
                .foregroundColor(.blue)
                .font(.caption2)
        }
    }
    
    private var chevronRightImage: some View {
        Image(systemName: "chevron.right")
            .resizable()
            .scaledToFit()
            .frame(width: 10, height: 10)
    }
}

#Preview {
    RecipeCellView(
        cuisine: "Malaysian",
        name: "Apam Balik",
        photoURLString: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
        sourceURLString: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ"
    )
    .padding()
    
    RecipeCellView(
        cuisine: "British",
        name: "Apple & Blackberry Crumble",
        photoURLString: "",
        sourceURLString: ""
    )
    .padding()
}
