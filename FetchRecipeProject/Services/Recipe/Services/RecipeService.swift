//
//  RecipeService.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/15/25.
//

import Foundation

protocol RecipeService {
    func fetchAllRecipes() async throws -> [Recipe]
    func fetchMalformedRecipes() async throws -> [Recipe]
    func fetchEmptyRecipes() async throws -> [Recipe]
}
