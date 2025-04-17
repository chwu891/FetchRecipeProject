//
//  CustomLoadingView.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/17/25.
//

import SwiftUI

struct CustomLoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            
            ProgressView("Loading...")
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 10)
        }
    }
}

#Preview {
    CustomLoadingView()
}
