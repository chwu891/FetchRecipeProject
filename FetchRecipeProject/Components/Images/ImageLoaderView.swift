//
//  ImageLoaderView.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/14/25.
//

import SwiftUI

@MainActor
class ImageLoaderViewModel: ObservableObject {
    
    @Published var image: UIImage?
    
    private var url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func loadImage() {
        let key = url.absoluteString
        
        if let cached = ImageCache.shared.image(forKey: key) {
            self.image = cached
            return
        }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    ImageCache.shared.store(image, forKey: key)
                    self.image = image
                }
            } catch {
                print("Failed to load image:", error)
            }
        }
    }
}

struct ImageLoaderView: View {
    
    @StateObject private var viewModel: ImageLoaderViewModel
    let url: URL
    
    init(url: URL) {
        self.url = url
        _viewModel = StateObject(wrappedValue: ImageLoaderViewModel(url: url))
    }
    
    var body: some View {
        Group {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
            }
        }
        .onAppear { viewModel.loadImage() }
    }
}

#Preview {
    ImageLoaderView(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")!)
        .frame(width: 100, height: 100)
}
