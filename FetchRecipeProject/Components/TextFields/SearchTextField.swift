//
//  SearchTextField.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/16/25.
//

import SwiftUI

struct SearchTextField: View {
    
    @Binding var searchText: String
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        HStack(spacing: 5) {
            TextField("Search for recipes", text: $searchText)
                .foregroundStyle(.primary)
                .font(.callout)
                .focused($isTextFieldFocused)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .foregroundStyle(searchText.isEmpty ? Color.gray : Color.black)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

#Preview {
    SearchTextField(searchText: .constant(""))
}
