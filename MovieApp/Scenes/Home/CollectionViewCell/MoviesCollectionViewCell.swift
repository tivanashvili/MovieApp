//
//  MoviesCollectionViewCell.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 17.07.23.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    private let moviePoster: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let favouriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Favorite"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let movieNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "Montserrat-VariableFont_wght.ttf", size: 10)
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private let movieYearLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "Montserrat-VariableFont_wght.ttf", size: 10)
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = .lightGray
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private let movieGenreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-VariableFont_wght.ttf", size: 10)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genreLabelContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "F5C518")
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupMoviePosterConstraints()
        setupGenreLabelContainerViewConstraints()
        setupMovieNameLabelConstraints()
        setupMovieYearLabelConstraints()
        setupFavouriteButtonConstraints()
        setupMovieGenreLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMoviePosterConstraints() {
        contentView.addSubview(moviePoster)
        NSLayoutConstraint.activate([
            moviePoster.topAnchor.constraint(equalTo: contentView.topAnchor),
            moviePoster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -44),
            moviePoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            moviePoster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setupMovieGenreLabelConstraints() {
        genreLabelContainerView.addSubview(movieGenreLabel)
        NSLayoutConstraint.activate([
            movieGenreLabel.topAnchor.constraint(equalTo: genreLabelContainerView.topAnchor, constant: 4),
            movieGenreLabel.leadingAnchor.constraint(equalTo: genreLabelContainerView.leadingAnchor, constant: 12),
            movieGenreLabel.trailingAnchor.constraint(equalTo: genreLabelContainerView.trailingAnchor, constant: -12),
            movieGenreLabel.bottomAnchor.constraint(equalTo: genreLabelContainerView.bottomAnchor, constant: -4)
        ])
    }
    
    private func setupMovieNameLabelConstraints() {
        contentView.addSubview(movieNameLabel)
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: 4),
            movieNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6)
        ])
    }
    
    private func setupMovieYearLabelConstraints() {
        contentView.addSubview(movieYearLabel)
        NSLayoutConstraint.activate([
            movieYearLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor),
            movieYearLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            movieYearLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupFavouriteButtonConstraints() {
        contentView.addSubview(favouriteButton)
        NSLayoutConstraint.activate([
            favouriteButton.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: 4),
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        ])
    }
    
    private func setupGenreLabelContainerViewConstraints() {
        moviePoster.addSubview(genreLabelContainerView)
        NSLayoutConstraint.activate([
            genreLabelContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            genreLabelContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            genreLabelContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            genreLabelContainerView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, constant: -20)
        ])
    }
    
    func configure(with movie: Movie) {
        moviePoster.image = UIImage(named: movie.poster)
        movieNameLabel.text = movie.name
        movieGenreLabel.text = movie.genre
        movieYearLabel.text = String(movie.year)
    }
}

extension MoviesCollectionViewCell {
    enum Constants {
        enum MoviePoster {
            static let backgroundColor = UIColor(hex: "1C1C1C")
            static let cornerRadius: CGFloat = 16
            static let leading: CGFloat = 16
        }
    }
}
