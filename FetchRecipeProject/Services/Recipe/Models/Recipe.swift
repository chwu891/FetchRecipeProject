//
//  Recipe.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/14/25.
//

import Foundation

struct Recipe: Codable, Hashable {
    let uuid: String
    let cuisine: String
    let name: String
    let photoURLLarge: String?
    let photoURLSmall: String?
    let sourceURL: String?
    let youtubeURL: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case cuisine
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}

extension Recipe {
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        [
            Recipe(
                uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                cuisine: "Malaysian",
                name: "Apam Balik",
                photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                sourceURL: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                youtubeURL: "https://www.youtube.com/watch?v=6R8ffRRJcrg"
            ),
            Recipe(
                uuid: "599344f4-3c5c-4cca-b914-2210e3b3312f",
                cuisine: "British",
                name: "Apple & Blackberry Crumble",
                photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
                sourceURL: "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
                youtubeURL: "https://www.youtube.com/watch?v=4vhcOwVBDO4"
            ),
            Recipe(
                uuid: "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
                cuisine: "British",
                name: "Apple Frangipan Tart",
                photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg",
                photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg",
                sourceURL: nil,
                youtubeURL: "https://www.youtube.com/watch?v=rp8Slv4INLk"
            )
        ]
    }
}
