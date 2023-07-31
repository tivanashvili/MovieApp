//
//  ErrorView.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 31.07.23.
//

import UIKit

final class ErrorView: UIView {
    
    // MARK: Components
    private let errorImageView: UIImageView = {
        let image = UIImageView()
        image.image = Constants.ErrorImageView.image
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.TitleLabel.text
        label.font = Constants.TitleLabel.font
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.DescriptionLabel.text
        label.font = Constants.DescriptionLabel.font
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.RefreshButton.image), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupErrorImageViewConstraints()
        setupTitleLabelConstraints()
        setupDescriptionLabelConstraints()
        setupRefreshButtonConstraints()
    }
    
    private func setupErrorImageViewConstraints() {
        addSubview(errorImageView)
        NSLayoutConstraint.activate([
            errorImageView.topAnchor.constraint(equalTo: topAnchor, constant: 220),
            errorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorImageView.heightAnchor.constraint(equalToConstant: 62),
            errorImageView.widthAnchor.constraint(equalToConstant: 62)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 28)
        ])
    }
    
    private func setupDescriptionLabelConstraints() {
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 248)
        ])
    }
    
    private func setupRefreshButtonConstraints() {
        addSubview(refreshButton)
        NSLayoutConstraint.activate([
            refreshButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            refreshButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 110)
        ])
    }
}

private extension ErrorView {
    enum Constants {
        enum ErrorImageView {
            static let image = UIImage(named: "error")
        }
        enum TitleLabel {
            static let text = "Data can't be loaded"
            static let font = UIFont.boldSystemFont(ofSize: 18)
        }
        
        enum DescriptionLabel {
            static let text = "internet connection or some other server error"
            static let font = UIFont(name: "Montserrat-VariableFont_wght.ttf", size: 16)
        }
        
        enum RefreshButton {
            static let image = "Refresh"
        }
    }
}
