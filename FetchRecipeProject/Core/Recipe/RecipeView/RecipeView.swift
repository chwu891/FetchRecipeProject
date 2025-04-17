//
//  RecipeView.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/15/25.
//

import SwiftUI

struct RecipeView: View {
    
    @StateObject var viewModel: RecipeViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                RecipeListView(recipes: viewModel.recipes, onRecipePressed: { recipe in
                    viewModel.selectedRecipe = recipe
                })
            }
            .navigationTitle("Fetch Recipe")
            .navigationDestination(isPresented: Binding(ifNotNil: $viewModel.selectedRecipe)) {
                if let selectedRecipe = viewModel.selectedRecipe {
                    RecipeDetailView(recipe: selectedRecipe)
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
    
}

#Preview {
    RecipeView(
        viewModel: RecipeViewModel(recipeManager: DevPreview.shared.recipeManager)
    )
}
