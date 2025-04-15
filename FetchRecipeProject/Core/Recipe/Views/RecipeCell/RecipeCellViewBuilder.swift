//
//  RecipeCellViewBuilder.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/15/25.
//

import SwiftUI

struct RecipeCellViewBuilder: View {
    
    let recipe: Recipe
    
    var body: some View {
        RecipeCellView(
            cuisine: recipe.cuisine,
            name: recipe.name,
            photoURLString: recipe.photoURLSmall ?? "",
            sourceURLString: recipe.sourceURL ?? ""
        )
    }
}

#Preview {
    RecipeCellViewBuilder(recipe: Recipe.mock)
}
