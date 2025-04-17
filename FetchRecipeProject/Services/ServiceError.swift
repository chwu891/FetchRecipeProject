//
//  ServiceError.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/17/25.
//

import Foundation

enum ServiceError: Error, LocalizedError {
    case decoding(DecodingError)
    case network(Error)
    case unknown

    var errorDescription: String? {
        switch self {
        case .decoding(let error):
            return Self.decodingMessage(for: error)
        case .network(let error as URLError):
            return Self.networkMessage(for: error)
        case .network(let error):
            return error.localizedDescription
        case .unknown:
            return "Something went wrong. Please try again later."
        }
    }

    private static func decodingMessage(for error: DecodingError) -> String {
        switch error {
        case .keyNotFound(let key, _):
            return "We're missing some important data (like '\(key.stringValue)'). Please try again later."
        case .typeMismatch:
            return "We received unexpected data. Please refresh or try again shortly."
        case .valueNotFound:
            return "Some expected values weren’t available. Please try again."
        case .dataCorrupted:
            return "The data was unreadable. Please refresh or come back later."
        @unknown default:
            return "We couldn't load the content properly. Please try again."
        }
    }

    private static func networkMessage(for error: URLError) -> String {
        switch error.code {
        case .notConnectedToInternet:
            return "You’re offline. Please check your internet connection."
        case .timedOut:
            return "The request took too long. Please try again."
        case .cannotFindHost, .cannotConnectToHost:
            return "We couldn’t reach the server. Please try again later."
        case .badURL:
            return "There’s a problem with the request. Please contact support."
        case .networkConnectionLost:
            return "Your connection was lost. Please try again."
        default:
            return "A network error occurred. Please try again."
        }
    }
}
