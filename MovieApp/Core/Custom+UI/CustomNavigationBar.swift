//
//  CustomNavigationBar.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 23.07.23.
//

import UIKit

protocol FavoriteButtonDelegate: AnyObject {
    func didTapFavoritesButton()
}

protocol HomeButtonDelegate: AnyObject {
    func didTapHomeButtonInFavorites()
}

final class CustomNavigationBar: UIView {
    
    // MARK: Components
    private let homeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let favoritesButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var favoriteButtonDelegate: FavoriteButtonDelegate?
    weak var homeButtonDelegate: HomeButtonDelegate?
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupHomeButtonConstraints()
        setupFavoritesButtonConstraints()
        setupFavoriteButton()
        setupHomeButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setupFavoriteButton() {
        let normalImage = UIImage(named: "favoritesButton")
        let selectedImage = UIImage(named: "selectedFavorites")
        
        favoritesButton.setImage(normalImage, for: .normal)
        favoritesButton.setImage(selectedImage, for: .selected)
        favoritesButton.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
    }
    
    private func setupHomeButton() {
        let normalImage = UIImage(named: "homeButton")
        let selectedImage = UIImage(named: "selectedHome")
        
        homeButton.setImage(normalImage, for: .normal)
        homeButton.setImage(selectedImage, for: .selected)
        homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func favoritesButtonTapped(_ sender: UIButton) {
        favoriteButtonDelegate?.didTapFavoritesButton()
    }
    
    @objc private func homeButtonTapped(_ sender: UIButton) {
        homeButtonDelegate?.didTapHomeButtonInFavorites()
    }
    
    func setFavoritesButtonSelected(_ isSelected: Bool) {
        favoritesButton.isSelected = isSelected
        homeButton.isSelected = !isSelected
    }
    
    private func setupHomeButtonConstraints() {
        addSubview(homeButton)
        NSLayoutConstraint.activate([
            homeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  16),
            homeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            homeButton.topAnchor.constraint(equalTo: topAnchor, constant: 12)
        ])
    }
    
    private func setupFavoritesButtonConstraints() {
        addSubview(favoritesButton)
        NSLayoutConstraint.activate([
            favoritesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -16),
            favoritesButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            favoritesButton.topAnchor.constraint(equalTo: topAnchor, constant: 12)
        ])
    }
    
}
