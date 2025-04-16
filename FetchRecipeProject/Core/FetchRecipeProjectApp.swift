//
//  FetchRecipeProjectApp.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/14/25.
//

import SwiftUI

@main
struct FetchRecipeProjectApp: App {
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(RecipeManager(service: DefaultRecipeService()))
        }
    }
}

@MainActor
class DevPreview {
    static let shared = DevPreview()
    
    let recipeManager: RecipeManager
    
    init() {
        recipeManager = RecipeManager(service: MockRecipeService())
    }
}
