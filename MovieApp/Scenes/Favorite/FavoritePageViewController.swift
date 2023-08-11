//
//  FavoritePageViewController.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 23.07.23.
//

import UIKit

final class FavoritePageViewController: UIViewController {
    
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
        view.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: Constants.MoviesCollectionView.reuseIdentifier)
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
        image.image = Constants.EmptyFavoritePageImageView.image
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: Properties
    private var isFavoriteButtonSelected = false
    
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
        customNavigationBar.setFavoritesButtonSelected(true)
        if movies.count == 0 {
            setupEmptyFavoritePageImageViewConstraints()
        }else {
            setupMoviesCollectionViewConstraints()
        }
        setupCustomNavigationBarConstraints()
    }
    
    // MARK: Setup Views
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
            moviesCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.MoviesCollectionView.top),
            moviesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.MoviesCollectionView.leading),
            moviesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.MoviesCollectionView.trailing),
            moviesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupCustomNavigationBarConstraints() {
        view.addSubview(customNavigationBar)
        NSLayoutConstraint.activate([
            customNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavigationBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customNavigationBar.heightAnchor.constraint(equalToConstant: Constants.CustomNavigationBar.height)
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

// MARK - MovieDetailsViewControllerDelegate
extension FavoritePageViewController: MovieDetailsViewControllerDelegate {
    func didTapBackButton() {
        dismiss(animated: true,completion: nil)
    }
}

// MARK: - CollectionViewDelegate
extension FavoritePageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MoviesCollectionView.reuseIdentifier, for: indexPath) as! FavoriteCollectionViewCell
        
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Constants.MoviesCollectionView.cellWidth, height: Constants.MoviesCollectionView.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView.cellForItem(at: indexPath) is FavoriteCollectionViewCell else {
            return
        }
        let vc = MovieDetailsViewController()
        vc.delegate = self
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
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
        
        enum MoviesCollectionView {
            static let reuseIdentifier = "FavoriteCollectionViewCell"
            static let top: CGFloat = 8
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -16
            static let cellHeight: CGFloat = 270
            static let cellWidth: CGFloat = 164
        }
        
        enum EmptyFavoritePageImageView {
            static let image = UIImage(named: "noMovies")
        }
        
        enum CustomNavigationBar {
            static let height: CGFloat = 70
        }
    }
}
