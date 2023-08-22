//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 22.08.23.
//

import Foundation

class HomeViewModel {
    private(set) var nowShowingMovies: [Movie] = []
    private(set) var comingSoonMovies: [Movie] = []
    private var selectedCategory: GenreCategory?
    
    func fetchNowShowingMovies(completion: @escaping (Result<[Movie], MovieAPIError>) -> Void) {
        let nowShowingEndpoint = "/filmsNowShowing/?n=25"
        let movieAPI = MovieAPI()
        movieAPI.fetchMovies(from: nowShowingEndpoint) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedMovies):
                    self.nowShowingMovies = fetchedMovies
                    completion(.success(fetchedMovies))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func fetchComingSoonMovies(completion: @escaping (Result<[Movie], MovieAPIError>) -> Void) {
        let comingSoonEndpoint = "/filmsComingSoon/?n=25"
        let movieAPI = MovieAPI()
        movieAPI.fetchMovies(from: comingSoonEndpoint) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedMovies):
                    self.comingSoonMovies = fetchedMovies
                    completion(.success(fetchedMovies))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getMoviesCount() -> Int {
        return selectedCategory == nil ? nowShowingMovies.count + comingSoonMovies.count : selectedCategory!.title == "filmsNowSHowing" ? nowShowingMovies.count : comingSoonMovies.count
    }
}
