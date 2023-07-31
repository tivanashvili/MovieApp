//
//  HomeViewController.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 17.07.23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: Components
    private lazy var searchBar: SearchBar = {
        let view = SearchBar()
        view.backgroundColor = Constants.SearchBar.backgroundColor
        view.layer.cornerRadius = Constants.SearchBar.cornerRadius
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var filterButton: FilterButton = {
        let button = FilterButton()
        button.delegate = self
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.CancelButton.title, for: .normal)
        button.titleLabel?.font = Constants.CancelButton.fontsize
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var movieCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.isScrollEnabled = true
        view.backgroundColor = .clear
        view.register(MovieCategoryCollectionViewCell.self, forCellWithReuseIdentifier: Constants.MovieCategoryCollectionView.reuseIdentifier)
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        view.backgroundColor = .clear
        view.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: Constants.MoviesCollectionView.reuseIdentifier)
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.TitleLabel.font
        label.text = Constants.TitleLabel.text
        label.textColor = Constants.TitleLabel.color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var customNavigationBar: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.favoriteButtonDelegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private let errorView: ErrorView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Properties
    private var isFilterSelected = false
    private var selectedIndexPath: IndexPath?
    private var filteredMovies: [Movie] = []
    
    private let categories = ["Action", "Drama", "Thriller", "Sci-Fi", "Action", "Comedy", "Drama", "Thriller", "Sci-Fi"]
    
    private let movies: [Movie] = [
        Movie(poster: "movie1", name: "The Baby Boss", genre: "Drama", year: 2017),
        Movie(poster: "movie2", name: "The Baby Boss", genre: "Thriller", year: 2016),
        Movie(poster: "movie3", name: "The Baby Boss", genre: "Action", year: 2017),
        Movie(poster: "movie4", name: "The Baby Boss", genre: "Thriller", year: 2017),
        Movie(poster: "movie4", name: "The Baby Boss", genre: "Thriller", year: 2017),
        Movie(poster: "movie4", name: "The Baby Boss", genre: "Action", year: 2017),
        Movie(poster: "movie4", name: "The Baby Boss", genre: "Action", year: 2017),
        Movie(poster: "movie4", name: "The Baby Boss", genre: "Drama", year: 2017),
        Movie(poster: "movie4", name: "The Baby Boss", genre: "Comedy", year: 2017),
        Movie(poster: "movie4", name: "The Baby Boss", genre: "Comedy", year: 2017),
    ]
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCategoryCollectionView.isHidden = true
        cancelButton.isHidden = true
        errorView.isHidden = true
        customNavigationBar.setFavoritesButtonSelected(false)
        setupViews()
        addTapGestureRecognizer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTitleLabelPosition()
    }
    
    @objc private func cancelButtonTapped() {
        filterButton.isHidden = false
        cancelButton.isHidden = true
    }
    
    // MARK: Actions
    private func showFavoritePageViewController() {
        DispatchQueue.main.async {
            let favoriteVC = FavoritePageViewController()
            let navController = UINavigationController(rootViewController: favoriteVC)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
    }
    
    private func showMovieDetailsViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Setup
    private func setupViews() {
        setupSearchBarConstraints()
        setupFilterButtonConstraints()
        setupCancelButtonConstraints()
        setupMovieCategoryCollectionView()
        setupTitleLabelConstraints()
        setupMoviesCollectionView()
        setupCustomNavigationBarConstraints()
        setupErrorViewConstraints()
    }
    
    private func addTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupSearchBarConstraints() {
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.SearchBar.leading)
        ])
    }
    
    private func setupFilterButtonConstraints() {
        view.addSubview(filterButton)
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.FilterButton.trailing),
            filterButton.widthAnchor.constraint(equalToConstant: Constants.FilterButton.width),
            filterButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: Constants.FilterButton.leading)
        ])
    }
    
    private func setupCancelButtonConstraints() {
        view.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.CancelButton.top),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.CancelButton.trailing),
            cancelButton.widthAnchor.constraint(equalToConstant: Constants.CancelButton.width),
            cancelButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: Constants.CancelButton.leading)
        ])
    }

    private func setupMovieCategoryCollectionView() {
        view.addSubview(movieCategoryCollectionView)
        NSLayoutConstraint.activate([
            movieCategoryCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: Constants.MovieCategoryCollectionView.top),
            movieCategoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.MovieCategoryCollectionView.leading),
            movieCategoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieCategoryCollectionView.heightAnchor.constraint(equalToConstant: Constants.MovieCategoryCollectionView.height)
        ])
    }
    
    private func setupMoviesCollectionView() {
        view.addSubview(moviesCollectionView)
        NSLayoutConstraint.activate([
            moviesCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            moviesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.MoviesCollectionView.leading),
            moviesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.MoviesCollectionView.trailing),
            moviesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: Constants.TitleLabel.top),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.TitleLabel.leading)
        ])
    }
    
    private func updateTitleLabelPosition() {
        titleLabel.frame.origin.y = searchBar.frame.maxY + (movieCategoryCollectionView.isHidden ? Constants.TitleLabel.hiddenCollectionView : Constants.TitleLabel.visibleCollectionView)
        moviesCollectionView.frame.origin.y = titleLabel.frame.maxY + Constants.MoviesCollectionView.maxY
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
    
    private func setupErrorViewConstraints() {
        view.addSubview(errorView)
        NSLayoutConstraint.activate([
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func calculateCellSize(for category: String) -> CGSize {
        let cellLabel = UILabel()
        cellLabel.text = category
        cellLabel.sizeToFit()
        let cellWidth = cellLabel.frame.width + Constants.MovieCategoryCollectionView.cellWidth
        return CGSize(width: cellWidth, height: Constants.MovieCategoryCollectionView.cellHeight)
    }
}

// MARK: - FilterButton Delegate
extension HomeViewController: FilterButtonDelegate {
    func didToggleFilterSection() {
        isFilterSelected = !isFilterSelected
        movieCategoryCollectionView.isHidden = !isFilterSelected
    }
}

// MARK: - FavoriteButton Delegate
extension HomeViewController: FavoriteButtonDelegate {
    func didTapFavoritesButton() {
        showFavoritePageViewController()
    }
}

// MARK: - MovieDetailsViewControllerDelegate
extension HomeViewController: MovieDetailsViewControllerDelegate {
    func didTapBackButton() {
        dismiss(animated: true,completion: nil)
    }
}

// MARK: - SearchBarDelegate
extension HomeViewController: SearchBarDelegate {
    func textFieldStartTyping() {
        filterButton.isHidden = true
        cancelButton.isHidden = false
    }
}

// MARK: - CollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == movieCategoryCollectionView {
            return categories.count
        } else if collectionView == moviesCollectionView {
            if isFilterSelected {
                return filteredMovies.count
            } else {
                return movies.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.movieCategoryCollectionView {
            let movieCategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCategoryCollectionViewCell", for: indexPath) as! MovieCategoryCollectionViewCell
            let category = categories[indexPath.row]
            movieCategoryCollectionViewCell.configure(with: category)
            return movieCategoryCollectionViewCell
        } else if collectionView == self.moviesCollectionView {
            let moviesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
            let movie: Movie
            if isFilterSelected {
                movie = filteredMovies[indexPath.row]
            } else {
                movie = movies[indexPath.row]
            }
            moviesCollectionViewCell.configure(with: movie)
            return moviesCollectionViewCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == movieCategoryCollectionView {
            guard let cell = collectionView.cellForItem(at: indexPath) as? MovieCategoryCollectionViewCell else {
                return
            }
            if indexPath == selectedIndexPath {
                cell.isSelectedCell = false
                selectedIndexPath = nil
                filteredMovies = movies
                
                moviesCollectionView.reloadData()
            } else {
                if let selectedIndexPath = selectedIndexPath, let selectedCell = collectionView.cellForItem(at: selectedIndexPath) as? MovieCategoryCollectionViewCell {
                    selectedCell.isSelectedCell = false
                }
                
                cell.isSelectedCell = true
                selectedIndexPath = indexPath
                
                let selectedCategory = categories[indexPath.row]
                filteredMovies = movies.filter { $0.genre == selectedCategory }
                
                moviesCollectionView.reloadData()
            }
        }
        
        if collectionView == moviesCollectionView {
            guard collectionView.cellForItem(at: indexPath) is MoviesCollectionViewCell else {
                return
            }
            let vc = MovieDetailsViewController()
            vc.delegate = self
            let navController = UINavigationController(rootViewController: vc)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == movieCategoryCollectionView {
            let category = categories[indexPath.row]
            let cellSize = calculateCellSize(for: category)
            return cellSize
        } else if collectionView == moviesCollectionView {
            return CGSize(width: Constants.MoviesCollectionView.cellWidth, height: Constants.MoviesCollectionView.cellHeight)
        }
        
        return CGSize()
    }
}

private extension HomeViewController {
    enum Constants {
        enum SearchBar {
            static let backgroundColor = UIColor(hex: "1C1C1C")
            static let cornerRadius: CGFloat = 16
            static let leading: CGFloat = 16
        }
        
        enum FilterButton {
            static let leading: CGFloat = 8
            static let width: CGFloat = 36
            static let trailing: CGFloat = -16
        }
        
        enum CancelButton {
            static let fontsize = UIFont.systemFont(ofSize: 12)
            static let title = "Cancel"
            static let leading: CGFloat = 8
            static let trailing: CGFloat = -13
            static let width: CGFloat = 36
            static let top: CGFloat = 4
        }
        
        enum MovieCategoryCollectionView {
            static let reuseIdentifier = "MovieCategoryCollectionViewCell"
            static let top: CGFloat = 8
            static let leading: CGFloat = 16
            static let height: CGFloat = 30
            static let cellWidth: CGFloat = 16
            static let cellHeight: CGFloat = 26
        }
        
        enum MoviesCollectionView {
            static let reuseIdentifier = "MoviesCollectionViewCell"
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -16
            static let maxY: CGFloat = 16
            static let cellWidth: CGFloat = 164
            static let cellHeight: CGFloat = 270
        }
        
        enum TitleLabel {
            static let color = UIColor(hex: "F5C518")
            static let text = "Movies"
            static let font = UIFont(name: "Montserrat-VariableFont_wght.ttf", size: 18)
            static let top: CGFloat = 52
            static let leading: CGFloat = 16
            static let visibleCollectionView: CGFloat = 52
            static let hiddenCollectionView: CGFloat = 22
        }
        
        enum CustomNavigationBar {
            static let height: CGFloat = 70
        }
    }
}
