//
//  NetworkService.swift
//  APIExercise2
//
//  Created by Froylan Almeida on 1/22/26.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .httpError(let statusCode):
            return "HTTP Error: \(statusCode)"
        case .decodingError:
            return "Failed to decode response"
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}

// Singleton
class NetworkService {
    static let shared = NetworkService()
    private let baseURL = "https://jsonplaceholder.typicode.com/users"
    
    private init() {}
    
    // Fetch All Data
    func fetchUsers() async throws -> [UsersResponse] {
        guard let url = URL(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        // Handle 200 response
        if httpResponse.statusCode == 200 {
            do {
                let users = try JSONDecoder().decode([UsersResponse].self, from: data)
                print(users)
                return users
            } catch {
                throw NetworkError.decodingError
            }
        } else {
            // Handle error responses
            throw NetworkError.httpError(statusCode: httpResponse.statusCode)
        }
    }
}
