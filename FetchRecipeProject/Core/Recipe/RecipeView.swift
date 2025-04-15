//
//  RecipeView.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/15/25.
//

import SwiftUI

struct RecipeView: View {
    
    @State private var selectedRecipe: Recipe?
    
    var body: some View {
        NavigationStack {
            VStack {
                RecipeListView(recipes: Recipe.mocks, onRecipePressed: { recipe in
                    selectedRecipe = recipe
                })
            }
            .navigationTitle("Fetch Recipe")
            .navigationDestination(item: $selectedRecipe) { recipe in
                RecipeDetailViewBuilder(recipe: recipe)
            }
        }
    }
    
}

#Preview {
    RecipeView()
}
