//
//  FavoritePageViewController.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 23.07.23.
//

import UIKit

class FavoritePageViewController: UIViewController {
    
    // MARK: Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.FavoriteMoviesLabel.text
        label.font = Constants.FavoriteMoviesLabel.font
        label.textAlignment = .center
        label.textColor = .white
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
    
    private lazy var customNavigationBar: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.homeButtonDelegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private let emptyFavoritePageImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "noMovies")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        setupTitleLabelConstraints()
        setupCustomNavigationBarConstraints()
        customNavigationBar.setFavoritesButtonSelected(true)
        if movies.count == 0 {
            setupEmptyFavoritePageImageViewConstraints()
        }else {
            setupMoviesCollectionViewConstraints()
        }
    }
    
    private func setupTitleLabelConstraints() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupMoviesCollectionViewConstraints() {
        view.addSubview(moviesCollectionView)
        NSLayoutConstraint.activate([
            moviesCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            moviesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            moviesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            moviesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupCustomNavigationBarConstraints() {
        view.addSubview(customNavigationBar)
        NSLayoutConstraint.activate([
            customNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavigationBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customNavigationBar.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setupEmptyFavoritePageImageViewConstraints() {
        view.addSubview(emptyFavoritePageImageView)
        NSLayoutConstraint.activate([
            emptyFavoritePageImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyFavoritePageImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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

extension FavoritePageViewController: HomeButtonDelegate {
    func didTapHomeButtonInFavorites() {
        dismiss(animated: true, completion: nil)
    }
}

private extension FavoritePageViewController {
    enum Constants {
        enum FavoriteMoviesLabel {
            static let text = "Favorite Movies"
            static let font = UIFont.boldSystemFont(ofSize: 18)
        }
    }
}
