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
    
    init(recipeManager: RecipeManager) {
        self.recipeManager = recipeManager
    }
    
    func onAppear() {
        Task {
            await fetchAllRecipes()
        }
    }
    
    func fetchAllRecipes() async {
        do {
            let fetchedRecipes = try await recipeManager.fetchAllRecipes()
            self.recipes = fetchedRecipes
        } catch {
            print(error)
        }
    }
    
    func fetchMalformedRecipes() async {
        do {
            let fetchedRecipes = try await recipeManager.fetchMalformedRecipes()
            self.recipes = fetchedRecipes
        } catch {
            print(error)
        }
    }
    
    func fetchEmptyRecipes() async {
        do {
            let fetchedRecipes = try await recipeManager.fetchEmptyRecipes()
            self.recipes = fetchedRecipes
        } catch {
            print(error)
        }
    }
}
