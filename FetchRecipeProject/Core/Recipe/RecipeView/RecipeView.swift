//
//  RecipeView.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/15/25.
//

import SwiftUI

struct RecipeView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @StateObject var viewModel: RecipeViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                headerView
                    .padding(.horizontal)
                    .padding(.top)
                
                if viewModel.filteredRecipes.isEmpty {
                    CustomEmptyView(title: "No Recipes Found")
                } else {
                    RecipeListView(recipes: viewModel.filteredRecipes, onRecipePressed: { recipe in
                        viewModel.onRecipeSelected(recipe)
                    })
                }
            }
            .overlay {
                if viewModel.isLoading {
                    CustomLoadingView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    settingsMenu
                }
            }
            .navigationTitle("Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: Binding(ifNotNil: $viewModel.selectedRecipe)) {
                if let selectedRecipe = viewModel.selectedRecipe {
                    RecipeDetailView(recipe: selectedRecipe)
                }
            }
            .alert(isPresented: Binding(ifNotNil: $viewModel.errorMessage)) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? ""),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onAppear {
                viewModel.onAppear()
            }
        }
    }
    
    private var headerView: some View {
        VStack {
            HStack {
                RefreshButton(action: viewModel.onRefreshButtonPressed)
                ItemsSelectionView(selectedItem: $viewModel.selectedCuisine, items: viewModel.cuisines)
            }
            SearchTextField(searchText: $viewModel.searchText)
        }
    }
    
    private var settingsMenu: some View {
        Menu {
            settingsMenuButton("Fetch All Recipes", action: viewModel.fetchAllRecipes)
            settingsMenuButton("Fetch Malformed Recipes", action: viewModel.fetchMalformedRecipes)
            settingsMenuButton("Fetch Empty Recipes", action: viewModel.fetchEmptyRecipes)
        } label: {
            Image(systemName: "ellipsis")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.primary)
        }
    }
    
    @ViewBuilder
    private func settingsMenuButton(_ title: String, action: @escaping () async -> Void) -> some View {
        Button(title) {
            Task {
                await action()
            }
        }
    }
}

#Preview {
    RecipeView(
        viewModel: RecipeViewModel(recipeManager: DevPreview.shared.recipeManager)
    )
}
