//
//  HomeView.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/15/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                RecipeListView(recipes: Recipe.mocks)
                    .padding()
            }
            .navigationTitle("Fetch Recipe")
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
