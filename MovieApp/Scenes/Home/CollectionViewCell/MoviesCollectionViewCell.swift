//
//  MoviesCollectionViewCell.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 17.07.23.
//

import UIKit

final class MoviesCollectionViewCell: UICollectionViewCell {
    
    private let moviePoster: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let favouriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.FavoriteButton.image), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let movieNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.customFont(.extraBold, size: Constants.FontSize.labelSize)
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = .white
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private let movieYearLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.customFont(.extraBold, size: Constants.FontSize.labelSize)
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = .lightGray
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private let movieGenreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(.extraBold, size: Constants.FontSize.labelSize)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genreLabelContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.GenreLabel.backgroundColor
        view.layer.cornerRadius = Constants.GenreLabel.cornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        setupMoviePosterConstraints()
        setupGenreLabelContainerViewConstraints()
        setupMovieNameLabelConstraints()
        setupMovieYearLabelConstraints()
        setupFavouriteButtonConstraints()
        setupMovieGenreLabelConstraints()
    }
    
    private func setupMoviePosterConstraints() {
        contentView.addSubview(moviePoster)
        NSLayoutConstraint.activate([
            moviePoster.topAnchor.constraint(equalTo: contentView.topAnchor),
            moviePoster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.MoviePoster.bottom),
            moviePoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            moviePoster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setupMovieGenreLabelConstraints() {
        genreLabelContainerView.addSubview(movieGenreLabel)
        NSLayoutConstraint.activate([
            movieGenreLabel.topAnchor.constraint(equalTo: genreLabelContainerView.topAnchor, constant: Constants.GenreLabel.top),
            movieGenreLabel.leadingAnchor.constraint(equalTo: genreLabelContainerView.leadingAnchor, constant: Constants.GenreLabel.leading),
            movieGenreLabel.trailingAnchor.constraint(equalTo: genreLabelContainerView.trailingAnchor, constant: Constants.GenreLabel.trailing),
            movieGenreLabel.bottomAnchor.constraint(equalTo: genreLabelContainerView.bottomAnchor, constant: Constants.GenreLabel.bottom)
        ])
    }
    
    private func setupMovieNameLabelConstraints() {
        contentView.addSubview(movieNameLabel)
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: Constants.MovieNameLabel.top),
            movieNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.MovieNameLabel.leading),
            movieNameLabel.widthAnchor.constraint(equalToConstant: Constants.MovieNameLabel.width)
        ])
    }
    
    private func setupMovieYearLabelConstraints() {
        contentView.addSubview(movieYearLabel)
        NSLayoutConstraint.activate([
            movieYearLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor),
            movieYearLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.MovieYearLabel.leading),
            movieYearLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupFavouriteButtonConstraints() {
        contentView.addSubview(favouriteButton)
        NSLayoutConstraint.activate([
            favouriteButton.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: Constants.FavoriteButton.top),
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.FavoriteButton.trailing)
        ])
    }
    
    private func setupGenreLabelContainerViewConstraints() {
        moviePoster.addSubview(genreLabelContainerView)
        NSLayoutConstraint.activate([
            genreLabelContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.GenreLabelContainer.top),
            genreLabelContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.GenreLabelContainer.trailing),
            genreLabelContainerView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, constant: Constants.GenreLabelContainer.width)
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
            static let bottom: CGFloat = -44
        }
        
        enum FavoriteButton {
            static let image = "Favorite"
            static let top: CGFloat = 4
            static let trailing: CGFloat = -4
        }
        
        enum MovieNameLabel {
            static let top: CGFloat = 4
            static let leading: CGFloat = 6
            static let width: CGFloat = 128
        }
        
        enum GenreLabel {
            static let backgroundColor = UIColor(hex: "F5C518")
            static let cornerRadius: CGFloat = 12
            static let top: CGFloat = 4
            static let leading: CGFloat = 12
            static let trailing: CGFloat = -12
            static let bottom: CGFloat = -4
        }
        
        enum MovieYearLabel {
            static let leading: CGFloat = 6
        }
        
        enum GenreLabelContainer {
            static let top: CGFloat = 10
            static let trailing: CGFloat = -10
            static let width: CGFloat = -20
        }
        
        enum FontSize {
            static let labelSize: CGFloat = 14
        }
    }
}
