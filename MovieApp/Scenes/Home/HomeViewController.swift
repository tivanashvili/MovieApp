//
//  HomeViewController.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 17.07.23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: Components
    private let searchBar: SearchBar = {
        let view = SearchBar()
        view.backgroundColor = Constants.SearchBar.backgroundColor
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var filterButton: FilterButton = {
        let button = FilterButton()
        button.delegate = self
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var movieCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        view.backgroundColor = .clear
        view.register(MovieCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCategoryCollectionViewCell")
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
        view.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-VariableFont_wght.ttf", size: 18)
        label.text = "Movies"
        label.textColor = UIColor(hex: "F5C518")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    private let customNavigationBar: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCategoryCollectionView.isHidden = true
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTitleLabelPosition()
    }
    
    // MARK: Properties
    private var isFilterSelected = false
    private var selectedIndexPath: IndexPath?
    
    private let categories = ["Action", "Comedytttttttttt", "Drama", "Thriller", "Sci-Fi", "Action", "Comedy", "Drama", "Thriller", "Sci-Fi"]
    
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
    
    private func setupViews() {
        setupFilterButtonConstraints()
        setupSearchBarConstraints()
        setupMovieCategoryCollectionView()
        setupTitleLabelConstraints()
        setupMoviesCollectionView()
        setupContainerViewConstraints()
    }
    
    private func setupSearchBarConstraints() {
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -8)
        ])
    }
    
    private func setupFilterButtonConstraints() {
        view.addSubview(filterButton)
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupMovieCategoryCollectionView() {
        view.addSubview(movieCategoryCollectionView)
        NSLayoutConstraint.activate([
            movieCategoryCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            movieCategoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            movieCategoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieCategoryCollectionView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupMoviesCollectionView() {
        view.addSubview(moviesCollectionView)
        NSLayoutConstraint.activate([
            moviesCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            moviesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            moviesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            moviesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        view.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 52).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    }
    
    private func updateTitleLabelPosition() {
        titleLabel.frame.origin.y = searchBar.frame.maxY + (movieCategoryCollectionView.isHidden ? 22 : 52)
        moviesCollectionView.frame.origin.y = titleLabel.frame.maxY + 16
    }
    
    private func setupContainerViewConstraints() {
        view.addSubview(customNavigationBar)
        NSLayoutConstraint.activate([
            customNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavigationBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customNavigationBar.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func calculateCellSize(for category: String) -> CGSize {
        let cellLabel = UILabel()
        cellLabel.text = category
        cellLabel.sizeToFit()
        let cellWidth = cellLabel.frame.width + 16
        return CGSize(width: cellWidth, height: 26)
    }
}

// MARK: - FilterButton Delegate
extension HomeViewController: FilterButtonDelegate {
    func didToggleFilterSection() {
        isFilterSelected = !isFilterSelected
        movieCategoryCollectionView.isHidden = !isFilterSelected
    }
}

// MARK: - CollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == movieCategoryCollectionView {
            return categories.count
        } else if collectionView == moviesCollectionView{
            return movies.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.movieCategoryCollectionView {
            let movieCategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCategoryCollectionViewCell", for: indexPath) as! MovieCategoryCollectionViewCell
            let category = categories[indexPath.row]
            movieCategoryCollectionViewCell.configure(with: category)
            
            return movieCategoryCollectionViewCell
            
        }
        else if collectionView == self.moviesCollectionView {
            let moviesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
            let movie = movies[indexPath.row]
            moviesCollectionViewCell.configure(with: movie)
            
            return moviesCollectionViewCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MovieCategoryCollectionViewCell else {
            return
        }
        
        if indexPath == selectedIndexPath {
            cell.isSelectedCell = false
            selectedIndexPath = nil
        } else {
            if let selectedIndexPath = selectedIndexPath, let selectedCell = collectionView.cellForItem(at: selectedIndexPath) as? MovieCategoryCollectionViewCell {
                selectedCell.isSelectedCell = false
            }
            
            cell.isSelectedCell = true
            selectedIndexPath = indexPath
        }
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == movieCategoryCollectionView {
            let category = categories[indexPath.row]
            let cellSize = calculateCellSize(for: category)
            return cellSize
        } else if collectionView == moviesCollectionView {
            return CGSize(width: 164, height: 270)
        }
        
        return CGSize()
    }
}

private extension HomeViewController {
    enum Constants {
        enum SearchBar {
            static let backgroundColor = UIColor(hex: "1C1C1C")
        }
    }
}
