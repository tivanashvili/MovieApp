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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 12
        view.backgroundColor = .black
        view.layer.borderColor = UIColor.white.cgColor
        view.register(MovieCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCategoryCollectionViewCell")
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "DASDADSADASD"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()
    
    var label1: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-VariableFont_wght.ttf", size: 16)
        label.text = "DASDADSADASD"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFilterButtonConstraints()
        setupSearchBarConstraints()
        setupCollectionViewConstraints()
    }
    
    private let categories = ["Action", "Comedy", "Drama", "Thriller", "Sci-Fi"]
    
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
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupCollectionViewConstraints() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.heightAnchor.constraint(equalToConstant: 21),
            collectionView.widthAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
    }
}

extension HomeViewController: FilterButtonDelegate {
    func didToggleFilterSection() {
        
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
}

private extension HomeViewController {
    enum Constants {
        enum SearchBar {
            static let backgroundColor = UIColor(hex: "1C1C1C")
        }
    }
}
