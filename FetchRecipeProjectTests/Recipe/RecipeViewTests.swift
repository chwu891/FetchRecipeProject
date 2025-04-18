//
//  RecipeViewTests.swift
//  FetchRecipeProjectTests
//
//  Created by Chi-Hsien Wu on 4/18/25.
//

import Testing
@testable import FetchRecipeProject

@MainActor
struct RecipeViewTests {
    
    @Test("Successfully fetches and sets recipes and cuisines without error")
    func testSuccessfulFetchAllRecipes() async throws {
        let recipeManager = RecipeManager(service: MockRecipeService())
        let viewModel = RecipeViewModel(recipeManager: recipeManager)
        let recipes = Recipe.mocks
        let cuisines = Array(Set(recipes.map { $0.cuisine })).sorted()
        
        await viewModel.fetchAllRecipes()
        
        #expect(viewModel.recipes.count == recipes.count, "Expected \(recipes.count) recipes, got \(viewModel.recipes.count)")
        #expect(viewModel.cuisines == cuisines, "Expected cuisines to be \(cuisines), got \(viewModel.cuisines)")
        #expect(viewModel.errorMessage == nil, "Expected no error message, got \(viewModel.errorMessage ?? "")")
        #expect(viewModel.isLoading == false, "Expected isLoading to be false after fetching, but got true")
    }
    
    @Test("fetchMalformedRecipes sets error message on failure")
    func testFetchMalformedRecipesSetsError() async throws {
        let recipeManager = RecipeManager(service: MockRecipeService())
        let viewModel = RecipeViewModel(recipeManager: recipeManager)
        
        await viewModel.fetchMalformedRecipes()
        
        #expect(viewModel.recipes.isEmpty, "Expected no recipes due to decoding error")
        #expect(viewModel.errorMessage != nil, "Expected error message to be set for malformed data")
        #expect(viewModel.isLoading == false, "Expected isLoading to be false after fetching, but got true")
    }

    @Test("fetchEmptyRecipes returns empty list without error")
    func testFetchEmptyRecipesReturnsEmptyList() async throws {
        let recipeManager = RecipeManager(service: MockRecipeService())
        let viewModel = RecipeViewModel(recipeManager: recipeManager)
        
        await viewModel.fetchEmptyRecipes()
        
        #expect(viewModel.recipes.isEmpty, "Expected empty recipes, got \(viewModel.recipes.count)")
        #expect(viewModel.errorMessage == nil, "Expected no error message, got \(viewModel.errorMessage ?? "")")
        #expect(viewModel.isLoading == false, "Expected isLoading to be false after fetching, but got true")
    }
}
