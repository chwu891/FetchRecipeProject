//
//  RecipeManager.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/15/25.
//

import Foundation

class RecipeManager: ObservableObject {
    
    private let service: RecipeService
    
    init(service: RecipeService) {
        self.service = service
    }
    
    func fetchAllRecipes() async throws -> [Recipe] {
        return try await service.fetchAllRecipes()
    }
    
    func fetchMalformedRecipes() async throws -> [Recipe] {
        return try await service.fetchMalformedRecipes()
    }
    
    func fetchEmptyRecipes() async throws -> [Recipe] {
        return try await service.fetchEmptyRecipes()
    }
}
