//
//  DefaultRecipeService.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/15/25.
//

import Foundation

struct DefaultRecipeService: RecipeService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = NetworkClient(baseURL: AppConfig.baseURL)) {
        self.networkClient = networkClient
    }
    
    func fetchAllRecipes() async throws -> [Recipe] {
        let response: RecipeResponse = try await networkClient.get(endpoint: "recipes.json")
        return response.recipes
    }
    
    func fetchMalformedRecipes() async throws -> [Recipe] {
        let response: RecipeResponse = try await networkClient.get(endpoint: "recipes-malformed.json")
        return response.recipes
    }
    
    func fetchEmptyRecipes() async throws -> [Recipe] {
        let response: RecipeResponse = try await networkClient.get(endpoint: "recipes-empty.json")
        return response.recipes
    }
}

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}
