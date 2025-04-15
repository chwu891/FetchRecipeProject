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
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            HStack(alignment: .top, spacing: 10) {
                recipePhotoView(photoURLString: photoURLString)
                
                VStack(alignment: .leading, spacing: 5) {
                    recipeCuisineView(cuisine: cuisine)
                    
                    recipeNameView(name: name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            chevronRightImage
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(uiColor: .secondarySystemBackground))
        )
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
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
            .lineLimit(1...2)
            .minimumScaleFactor(0.8)
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
        photoURLString: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"
    )
    .padding()
    
    RecipeCellView(
        cuisine: "British",
        name: "Apple & Blackberry Crumble",
        photoURLString: ""
    )
    .padding()
}
