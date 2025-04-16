//
//  AppView.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/15/25.
//

import SwiftUI

struct AppView: View {
    
    @EnvironmentObject private var recipeManager: RecipeManager
    
    var body: some View {
        RecipeView(
            viewModel: RecipeViewModel(recipeManager: recipeManager)
        )
    }
}

#Preview {
    AppView()
}
