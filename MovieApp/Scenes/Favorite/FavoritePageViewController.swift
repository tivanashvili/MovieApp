//
//  FavoritePageViewController.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 23.07.23.
//

import UIKit

class FavoritePageViewController: UIViewController {
    
    // MARK: Components
    private let favoriteMoviesLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.FavoriteMoviesLabel.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        view.backgroundColor = .clear
        view.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: "FavoriteCollectionViewCell")
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let movies: [Movie] = [
        Movie(poster: "movie1", name: "The Baby Boss", genre: "d", year: 2017),
        Movie(poster: "movie2", name: "The Baby Boss", genre: "ComedyttttttttttComedyttttttttttComedytttttttttt", year: 2016),
        Movie(poster: "movie3", name: "The Baby Boss", genre: "Comedy", year: 2017),
        Movie(poster: "movie4", name: "The Baby Boss", genre: "Comedy", year: 2017),
        Movie(poster: "movie4", name: "The Baby Boss", genre: "Comedy", year: 2017),
        Movie(poster: "movie4", name: "The Baby Boss", genre: "Comedy", year: 2017),
        Movie(poster: "movie4", name: "The Baby Boss", genre: "Comedy", year: 2017),
        Movie(poster: "movie4", name: "The Baby Boss", genre: "Comedy", year: 2017),
        Movie(poster: "movie4", name: "The Baby Boss", genre: "Comedy", year: 2017),
        Movie(poster: "movie4", name: "The Baby Boss", genre: "Comedy", year: 2017),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFavoriteMoviesLabelConstraints()
    }
    
    private func setupFavoriteMoviesLabelConstraints() {
        view.addSubview(favoriteMoviesLabel)
        NSLayoutConstraint.activate([
            favoriteMoviesLabel.topAnchor.constraint(equalTo: view.topAnchor),
            favoriteMoviesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupMoviesCollectionViewConstraints() {
        view.addSubview(moviesCollectionView)
        NSLayoutConstraint.activate([
            moviesCollectionView.topAnchor.constraint(equalTo: favoriteMoviesLabel.bottomAnchor),
            moviesCollectionView.topAnchor.constraint(equalTo: favoriteMoviesLabel.bottomAnchor),

        ])
    }

}

// MARK: - CollectionViewDelegate
extension FavoritePageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 164, height: 270)
    }
}

private extension FavoritePageViewController {
    enum Constants {
        enum FavoriteMoviesLabel {
            static let text = "Favorite Movies"
        }
    }
}
