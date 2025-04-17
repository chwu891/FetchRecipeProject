//
//  RefreshButton.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/17/25.
//

import SwiftUI

struct RefreshButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "goforward")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.primary)
        }
        .buttonStyle(PressableButtonStyle())
    }
}

#Preview {
    RefreshButton(action: {})
}
