//
//  MovieAPI.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 16.08.23.
//

import Foundation

enum MovieAPIError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
}

class MovieAPI {

    private let baseURL = "https://api-gate2.movieglu.com"
    private let apiKey = "BUIAmB47Uq8cT3skzP5i98vXBRBPPv9W8CTEFFVA"

    private func createURLRequest(endpoint: String) -> URLRequest? {
        guard let url = URL(string: baseURL + endpoint) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("EVEN_0", forHTTPHeaderField: "client")
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue("Basic RVZFTl8wX1hYOkxPaGZMUFB2ZjlUaw==", forHTTPHeaderField: "authorization")
        request.setValue("XX", forHTTPHeaderField: "territory")
        request.setValue("v200", forHTTPHeaderField: "api-version")
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let currentDateString = dateFormatter.string(from: Date())
        request.setValue(currentDateString, forHTTPHeaderField: "device-datetime")
        
        return request
    }

    func fetchMovies(from endpoint: String, completion: @escaping (Result<[Movie], MovieAPIError>) -> Void) {
        guard let request = createURLRequest(endpoint: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }

            if let response = response as? HTTPURLResponse {
                print("HTTP status code: \(response.statusCode)")
            }

            if let data = data {
                do {
                    let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)

                    if let movies = movieResponse.films {
                        completion(.success(movies))
                    } else {
                        completion(.success([]))
                    }
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            } else {
                completion(.failure(.invalidResponse))
            }
        }
        task.resume()
    }
}
