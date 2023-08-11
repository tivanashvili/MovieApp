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
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let favoritesButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var favoriteButtonDelegate: FavoriteButtonDelegate?
    weak var homeButtonDelegate: HomeButtonDelegate?
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setupViews() {
        setupHomeButtonConstraints()
        setupFavoritesButtonConstraints()
        setupFavoriteButton()
        setupHomeButton()
    }
    
    private func setupFavoriteButton() {
        favoritesButton.setImage(Constants.favoriteButtonImage, for: .normal)
        favoritesButton.setImage(Constants.selectedFavoriteButtonImage, for: .selected)
        favoritesButton.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
    }
    
    private func setupHomeButton() {
        homeButton.setImage(Constants.homeButtonImage, for: .normal)
        homeButton.setImage(Constants.selectedHomeButtonImage, for: .selected)
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
            homeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  Constants.buttonLeading),
            homeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.buttonBottom),
            homeButton.topAnchor.constraint(equalTo: topAnchor, constant: Constants.buttonTop)
        ])
    }
    
    private func setupFavoritesButtonConstraints() {
        addSubview(favoritesButton)
        NSLayoutConstraint.activate([
            favoritesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -Constants.buttonTrailing),
            favoritesButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.buttonBottom),
            favoritesButton.topAnchor.constraint(equalTo: topAnchor, constant: Constants.buttonTop)
        ])
    }
}

extension CustomNavigationBar {
    enum Constants {
        static let buttonCornerRadius: CGFloat = 12
        static let buttonLeading: CGFloat = 16
        static let buttonTrailing: CGFloat = 16
        static let buttonTop: CGFloat = 12
        static let buttonBottom: CGFloat = 12
        static let favoriteButtonImage = UIImage(named: "favoritesButton")
        static let selectedFavoriteButtonImage = UIImage(named: "selectedFavorites")
        static let homeButtonImage = UIImage(named: "homeButton")
        static let selectedHomeButtonImage = UIImage(named: "selectedHome")
    }
}
