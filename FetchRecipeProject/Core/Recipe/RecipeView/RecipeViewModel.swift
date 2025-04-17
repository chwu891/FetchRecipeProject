//
//  RecipeViewModel.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/16/25.
//

import SwiftUI

@MainActor
class RecipeViewModel: ObservableObject {
    
    private let recipeManager: RecipeManager
    
    @Published var recipes: [Recipe] = []
    @Published var selectedRecipe: Recipe?
    @Published var cuisines: [String] = []
    @Published var selectedCuisine: String?
    @Published var searchText: String = ""
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    init(recipeManager: RecipeManager) {
        self.recipeManager = recipeManager
    }
    
    var filteredRecipes: [Recipe] {
        recipes.filter { recipe in
            let matchCuisine = selectedCuisine == nil || recipe.cuisine == selectedCuisine
            let matchSearch = searchText.isEmpty || recipe.name.lowercased().contains(searchText.lowercased()) || recipe.cuisine.lowercased().contains(searchText.lowercased())
            return matchCuisine && matchSearch
        }
    }
    
    func onAppear() {
        Task {
            await fetchAllRecipes()
        }
    }
    
    func onRefreshButtonPressed() {
        Task {
            await fetchAllRecipes()
        }
    }
    
    func onRecipeSelected(_ recipe: Recipe) {
        self.selectedRecipe = recipe
    }
    
    func fetchAllRecipes() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let fetchedRecipes = try await recipeManager.fetchAllRecipes()
            self.recipes = fetchedRecipes
            self.cuisines = Array(Set(fetchedRecipes.map { $0.cuisine })).sorted()
        } catch let error as ServiceError {
            self.errorMessage = error.localizedDescription
        } catch {
            self.errorMessage = "Something went wrong. Please try again."
        }
    }
    
    func fetchMalformedRecipes() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let fetchedRecipes = try await recipeManager.fetchMalformedRecipes()
            self.recipes = fetchedRecipes
        } catch let error as ServiceError {
            self.errorMessage = error.localizedDescription
        } catch {
            self.errorMessage = "Something went wrong. Please try again."
        }
    }
    
    func fetchEmptyRecipes() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let fetchedRecipes = try await recipeManager.fetchEmptyRecipes()
            self.recipes = fetchedRecipes
        } catch let error as ServiceError {
            self.errorMessage = error.localizedDescription
        } catch {
            self.errorMessage = "Something went wrong. Please try again."
        }
    }
}
