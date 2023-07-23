//
//  CustomNavigationBar.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 23.07.23.
//

import UIKit

final class CustomNavigationBar: UIView {
    
    // MARK: Components
    private let homeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.setImage(UIImage(named: "selectedHome"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let favoritesButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.setImage(UIImage(named: "favoritesButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupHomeButtonConstraints()
        setupFavoritesButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
