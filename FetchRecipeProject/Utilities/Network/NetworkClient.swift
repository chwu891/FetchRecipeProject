//
//  NetworkClient.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/15/25.
//

import Foundation

final class NetworkClient {
    
    private let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func get<T: Decodable>(
        endpoint: String,
        queryItems: [URLQueryItem] = []
    ) async throws -> T {
        let url = try buildURL(endpoint: endpoint, queryItems: queryItems)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch let error as DecodingError {
            printDecodingError(error)
            throw error
        } catch {
            throw error
        }
    }
    
    private func buildURL(endpoint: String, queryItems: [URLQueryItem]) throws -> URL {
        var components = URLComponents(url: baseURL.appendingPathComponent(endpoint), resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        return url
    }
    
    private func printDecodingError(_ error: DecodingError) {
        switch error {
        case .keyNotFound(let key, let context):
            print("❌ Key '\(key.stringValue)' not found – \(context.debugDescription)")
        case .typeMismatch(let type, let context):
            print("❌ Type mismatch – Expected \(type) – \(context.debugDescription)")
        case .valueNotFound(let value, let context):
            print("❌ Value '\(value)' not found – \(context.debugDescription)")
        case .dataCorrupted(let context):
            print("❌ Data corrupted – \(context.debugDescription)")
        @unknown default:
            print("❌ Unknown decoding error.")
        }
    }
}
