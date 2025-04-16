//
//  MockRecipeService.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/15/25.
//

import Foundation

struct MockRecipeService: RecipeService {
    
    func fetchAllRecipes() async throws -> [Recipe] {
        Recipe.mocks
    }
    
    func fetchMalformedRecipes() async throws -> [Recipe] {
        struct RecipeResponse: Decodable {
            let recipes: [Recipe]
        }
        
        let malformedJSON = """
                {
                    "recipes": [
                        {
                            "uuid": "123",
                            "cuisine": "French"
                        }
                    ]
                }
                """
        
        let data = Data(malformedJSON.utf8)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decoded = try decoder.decode(RecipeResponse.self, from: data)
        return decoded.recipes
    }
    
    func fetchEmptyRecipes() async throws -> [Recipe] {
        []
    }
}
