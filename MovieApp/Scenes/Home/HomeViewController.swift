//
//  HomeViewController.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 17.07.23.
//

import UIKit

final class HomeViewController: UIViewController {
    
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
        view.layer.borderColor = UIColor.white.cgColor
        view.register(MovieCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCategoryCollectionViewCell")
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

    override func viewDidLoad() {
        super.viewDidLoad()
        movieCategoryCollectionView.isHidden = true
        setupFilterButtonConstraints()
        setupSearchBarConstraints()
        setupCollectionViewConstraints()
        setupTitleLabelConstraints()
    }
    
    private var isFilterSelected = false
    private var titleLabelTopConstraint: NSLayoutConstraint!
    
    private let categories = ["Action", "Comedytttttttttt", "Drama", "Thriller", "Sci-Fi", "Action", "Comedy", "Drama", "Thriller", "Sci-Fi"]
    
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
    
    private func setupCollectionViewConstraints() {
        view.addSubview(movieCategoryCollectionView)
        NSLayoutConstraint.activate([
            movieCategoryCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            movieCategoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            movieCategoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieCategoryCollectionView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        view.addSubview(titleLabel)
        titleLabelTopConstraint = titleLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 22)
        NSLayoutConstraint.activate([
            titleLabelTopConstraint,
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
        if movieCategoryCollectionView.isHidden {
            titleLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 22).isActive = false
        }else {
            titleLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 52).isActive = true
        }
    }
}

extension HomeViewController: FilterButtonDelegate {
    func didToggleFilterSection() {
        isFilterSelected = !isFilterSelected
        movieCategoryCollectionView.isHidden = !isFilterSelected
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCategoryCollectionViewCell", for: indexPath) as! MovieCategoryCollectionViewCell
        let category = categories[indexPath.row]
        cell.configure(with: category)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MovieCategoryCollectionViewCell else {
            return
        }
        cell.backgroundColor = UIColor(hex: "F5C518")
        cell.setLabelTextColor(UIColor.black)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let category = categories[indexPath.row]

        let cell = MovieCategoryCollectionViewCell(frame: CGRect.zero)
        cell.configure(with: category)
        cell.cellLabel.preferredMaxLayoutWidth = collectionView.bounds.width - 16
        let labelSize = cell.cellLabel.intrinsicContentSize
        let cellWidth = labelSize.width + 16
        return CGSize(width: cellWidth, height: 26)
    }
}

private extension HomeViewController {
    enum Constants {
        enum SearchBar {
            static let backgroundColor = UIColor(hex: "1C1C1C")
        }
    }
}
