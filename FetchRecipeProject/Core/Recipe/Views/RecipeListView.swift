//
//  RecipeListView.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/14/25.
//

import SwiftUI

struct RecipeListView: View {
    
    let recipes: [Recipe]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(recipes, id:\.uuid) { recipe in
                    Button {
                        // To do
                    } label: {
                        RecipeCellViewBuilder(recipe: recipe)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                    .buttonStyle(PressableButtonStyle())
                }
            }
        }
    }
}

struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.smooth, value: configuration.isPressed)
    }
}

#Preview {
    RecipeListView(recipes: Recipe.mocks)
        .padding()
}
