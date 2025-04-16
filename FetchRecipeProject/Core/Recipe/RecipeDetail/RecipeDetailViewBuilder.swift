//
//  RecipeDetailViewBuilder.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/15/25.
//

import SwiftUI

struct RecipeDetailViewBuilder: View {
    
    let recipe: Recipe
    
    var body: some View {
        RecipeDetailView(
            cuisine: recipe.cuisine,
            name: recipe.name,
            photoURLString: recipe.photoURLLarge ?? "",
            sourceURLString: recipe.sourceURL ?? "",
            youtubeURLString: recipe.youtubeURL ?? ""
        )
    }
}

#Preview {
    RecipeDetailViewBuilder(recipe: Recipe.mock)
}
