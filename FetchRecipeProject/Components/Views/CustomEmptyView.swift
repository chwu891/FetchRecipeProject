//
//  CustomEmptyView.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/17/25.
//

import SwiftUI

struct CustomEmptyView: View {
    
    let title: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "tray")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundStyle(.secondary)
            
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
        }
        .multilineTextAlignment(.center)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CustomEmptyView(title: "No Recipes Found")
}
