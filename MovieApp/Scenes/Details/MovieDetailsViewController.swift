//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 24.07.23.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    // MARK: Components
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.FavoriteMoviesLabel.text
        label.font = Constants.FavoriteMoviesLabel.font
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moviePoster: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "movie3")
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let trailerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Trailer"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Favorite"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.text = "The Atonement"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieRatingsLabel: LabelsContainerView = {
        let label = LabelsContainerView()
        label.labelText = "7.9"
        label.image = UIImage(named: "star")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieGenreLabel: LabelsContainerView = {
        let label = LabelsContainerView()
        label.labelText = "Romance"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let movieDurationLabel: LabelsContainerView = {
        let label = LabelsContainerView()
        label.labelText = "1h 50m"
        label.image = UIImage(named: "clock")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieYearLabel: LabelsContainerView = {
        let label = LabelsContainerView()
        label.labelText = "2007"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let aboutMovieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "About Movie"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Thirteen-year-old fledgling writer Briony Tallis irrevocably changes the course of several lives when she accuses her older sister's lover of a crime he did not commit."
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        setupTitleLabelConstraints()
        setupMoviePosterConstraints()
        setupMovieNameLabelConstraints()
        setupLabelsStackView()
        setupAboutMovieLabelConstraints()
        setupScrollViewConstraints()
        setupMovieDescriptionLabelConstraint()
        setupBackButtonConstraints()
        setupTrailerButtonConstraints()
        setupFavoriteButtonConstraints()
    }
    
    private func setupTitleLabelConstraints() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupMoviePosterConstraints() {
        view.addSubview(moviePoster)
        NSLayoutConstraint.activate([
            moviePoster.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            moviePoster.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviePoster.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviePoster.heightAnchor.constraint(equalToConstant: 360)
        ])
    }
    
    private func setupFavoriteButtonConstraints() {
        view.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            favoriteButton.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: 26)
        ])
    }
    
    private func setupMovieNameLabelConstraints() {
        view.addSubview(movieNameLabel)
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: 26),
            movieNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            movieNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 26)
        ])
    }
    
    private func setupLabelsStackView() {
        view.addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(movieRatingsLabel)
        labelsStackView.addArrangedSubview(movieGenreLabel)
        labelsStackView.addArrangedSubview(movieDurationLabel)
        labelsStackView.addArrangedSubview(movieYearLabel)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 12),
            labelsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            labelsStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -40),
            labelsStackView.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    private func setupAboutMovieLabelConstraints() {
        view.addSubview(aboutMovieLabel)
        NSLayoutConstraint.activate([
            aboutMovieLabel.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 22),
            aboutMovieLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            aboutMovieLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 22)
        ])
    }
    
    private func setupMovieDescriptionLabelConstraint() {
        scrollView.addSubview(movieDescriptionLabel)
        NSLayoutConstraint.activate([
            movieDescriptionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            movieDescriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            movieDescriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            movieDescriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            movieDescriptionLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupScrollViewConstraints() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: aboutMovieLabel.bottomAnchor, constant: 8)
        ])
    }
    
    private func setupBackButtonConstraints() {
        titleLabel.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 23),
            backButton.heightAnchor.constraint(equalToConstant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 12)
        ])
    }
    
    private func setupTrailerButtonConstraints() {
        moviePoster.addSubview(trailerButton)
        NSLayoutConstraint.activate([
            trailerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            trailerButton.bottomAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: -20)
        ])
    }
}

private extension MovieDetailsViewController {
    enum Constants {
        enum FavoriteMoviesLabel {
            static let text = "Details"
            static let font = UIFont.boldSystemFont(ofSize: 18)
        }
    }
}
