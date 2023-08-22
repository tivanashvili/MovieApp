//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 22.08.23.
//

import Foundation

class HomeViewModel {
    var movies: [Movie] = []
    var selectedCategory: GenreCategory?

    func fetchMovies(completion: @escaping (Result<[Movie], MovieAPIError>) -> Void) {
        // Create a MovieAPI instance and fetch movies
        let movieAPI = MovieAPI()
        movieAPI.fetchMovies { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedMovies):
                    self.movies = fetchedMovies
                    completion(.success(fetchedMovies))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getMoviesCount() -> Int {
        return movies.count
    }

    func getMovie(at index: Int) -> Movie? {
        guard index >= 0 && index < movies.count else {
            return nil
        }
        return movies[index]
    }
}
