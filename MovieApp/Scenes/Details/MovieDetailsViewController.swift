//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 24.07.23.
//

import UIKit

protocol MovieDetailsViewControllerDelegate: AnyObject {
    func didTapBackButton()
}

class MovieDetailsViewController: UIViewController {
    
    // MARK: Components
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.BackButton.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    private let moviePoster: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = Constants.MoviePoster.image
        image.backgroundColor = .black
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let trailerButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.TrailerButton.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.FavoriteButton.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(.regular, size: Constants.FontSize.labelSize)
        label.textAlignment = .left
        label.text = Constants.MovieNameLabel.text
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieRatingsLabel: LabelsContainerView = {
        let label = LabelsContainerView()
        label.labelText = Constants.MovieRatingLabel.text
        label.image = Constants.MovieRatingLabel.image
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieGenreLabel: LabelsContainerView = {
        let label = LabelsContainerView()
        label.labelText = Constants.MovieGenreLabel.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieDurationLabel: LabelsContainerView = {
        let label = LabelsContainerView()
        label.labelText = Constants.MovieDurationLabel.text
        label.image = Constants.MovieDurationLabel.image
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieYearLabel: LabelsContainerView = {
        let label = LabelsContainerView()
        label.labelText = Constants.MovieYearLabel.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let aboutMovieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(.extraBold, size: Constants.FontSize.aboutMovieLabelSize)
        label.textAlignment = .left
        label.text = Constants.AboutMovieLabel.text
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(.regular, size: Constants.FontSize.movieDescriptionSize)
        label.text = Constants.MovieDescriptionLabel.text
        label.textColor = .white
        label.numberOfLines = Constants.MovieDescriptionLabel.numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = Constants.LabelsStackView.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // MARK: Properties
    weak var delegate: MovieDetailsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        setupBackButtonConstraints()
        setupTitleLabelConstraints()
        setupMoviePosterConstraints()
        setupMovieNameLabelConstraints()
        setupLabelsStackView()
        setupAboutMovieLabelConstraints()
        setupScrollViewConstraints()
        setupMovieDescriptionLabelConstraint()
        setupTrailerButtonConstraints()
        setupFavoriteButtonConstraints()
    }
    
    @objc private func backButtonTapped() {
        delegate?.didTapBackButton()
    }
    
    // MARK: Setup Views
    private func setupBackButtonConstraints() {
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.BackButton.topConstraint),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.BackButton.leadingConstraint),
            backButton.heightAnchor.constraint(equalToConstant: Constants.BackButton.height),
            backButton.widthAnchor.constraint(equalToConstant: Constants.BackButton.width)
        ])
    }
    
    private func setupTitleLabelConstraints() {
         view.addSubview(titleLabel)
         NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.TitleLabel.top),
             titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor),
             titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.TitleLabel.height),
             titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
         ])
     }
    
    private func setupMoviePosterConstraints() {
        view.addSubview(moviePoster)
        NSLayoutConstraint.activate([
            moviePoster.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            moviePoster.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviePoster.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviePoster.heightAnchor.constraint(equalToConstant: Constants.MoviePoster.height)
        ])
    }
    
    private func setupFavoriteButtonConstraints() {
        view.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.FavoriteButton.trailingConstraint),
            favoriteButton.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: Constants.FavoriteButton.topConstraint),
            favoriteButton.heightAnchor.constraint(equalToConstant: Constants.FavoriteButton.height),
            favoriteButton.widthAnchor.constraint(equalToConstant: Constants.FavoriteButton.width)
        ])
    }
    
    private func setupMovieNameLabelConstraints() {
        view.addSubview(movieNameLabel)
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: Constants.MovieNameLabel.topConstraint),
            movieNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.MovieNameLabel.leadingConstraint),
            movieNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.MovieNameLabel.minHeight)
        ])
    }
    
    private func setupLabelsStackView() {
        view.addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(movieRatingsLabel)
        labelsStackView.addArrangedSubview(movieGenreLabel)
        labelsStackView.addArrangedSubview(movieDurationLabel)
        labelsStackView.addArrangedSubview(movieYearLabel)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: Constants.LabelsStackView.top),
            labelsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.LabelsStackView.leading),
            labelsStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: Constants.LabelsStackView.trailing),
            labelsStackView.heightAnchor.constraint(equalToConstant: Constants.LabelsStackView.height)
        ])
    }
    
    private func setupAboutMovieLabelConstraints() {
        view.addSubview(aboutMovieLabel)
        NSLayoutConstraint.activate([
            aboutMovieLabel.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: Constants.AboutMovieLabel.topConstraint),
            aboutMovieLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.AboutMovieLabel.leadingConstraint),
            aboutMovieLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.AboutMovieLabel.minHeight)
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
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.ScrollView.leading),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.ScrollView.trailing),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: aboutMovieLabel.bottomAnchor, constant: Constants.ScrollView.top)
        ])
    }
    
    private func setupTrailerButtonConstraints() {
        moviePoster.addSubview(trailerButton)
        trailerButton.addTarget(self, action: #selector(trailerButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            trailerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.TrailerButton.trailingConstraint),
            trailerButton.bottomAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: Constants.TrailerButton.bottomConstraint)
        ])
    }
    
    @objc func trailerButtonTapped() {
        guard let videoURL = Bundle.main.url(forResource: Constants.TrailerButton.videoFileName, withExtension: Constants.TrailerButton.videoFileExtension) else {
            print("Video file not found.")
            return
        }
        let vc = MovieTrailerViewController(videoURL: videoURL)
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
}

private extension MovieDetailsViewController {
    enum Constants {
        enum TitleLabel {
            static let text = "Details"
            static let font = UIFont.customFont(.extraBold, size: 18)
            static let top: CGFloat = -10
            static let height: CGFloat = 40
        }
        
        enum BackButton {
            static let image = UIImage(named: "back")
            static let topConstraint: CGFloat = 0
            static let leadingConstraint: CGFloat = 22
            static let height: CGFloat = 20
            static let width: CGFloat = 12
        }
        
        enum MoviePoster {
            static let contentMode: UIView.ContentMode = .scaleToFill
            static let backgroundColor: UIColor = .black
            static let image = UIImage(named: "movie3")
            static let height: CGFloat = 380
        }
        
        enum TrailerButton {
            static let image = UIImage(named: "Trailer")
            static let trailingConstraint: CGFloat = -16
            static let bottomConstraint: CGFloat = -20
            static let videoFileName = "video123"
            static let videoFileExtension = "mp4"
        }
        
        enum FavoriteButton {
            static let image = UIImage(named: "Favorite")
            static let trailingConstraint: CGFloat = -16
            static let topConstraint: CGFloat = 26
            static let height: CGFloat = 22
            static let width: CGFloat = 26
        }
        
        enum MovieNameLabel {
            static let font = UIFont.boldSystemFont(ofSize: 20)
            static let text = "The Atonement"
            static let leadingConstraint: CGFloat = 16
            static let topConstraint: CGFloat = 26
            static let minHeight: CGFloat = 26
        }
        
        enum MovieRatingLabel {
            static let font = UIFont.systemFont(ofSize: 14)
            static let text = "7.9"
            static let image = UIImage(named: "star")
        }
        
        enum MovieGenreLabel {
            static let text = "Romance"
        }
        
        enum MovieDurationLabel {
            static let image = UIImage(named: "clock")
            static let text = "1h 50min"
        }
        
        enum AboutMovieLabel {
            static let font = UIFont.boldSystemFont(ofSize: 16)
            static let text = "About Movie"
            static let leadingConstraint: CGFloat = 16
            static let topConstraint: CGFloat = 22
            static let minHeight: CGFloat = 22
        }
        
        enum MovieYearLabel {
            static let text = "2007"
        }
        
        enum MovieDescriptionLabel {
            static let text = "Thirteen-year-old fledgling writer Briony Tallis irrevocably changes the course of several lives when she accuses her older sister's lover of a crime he did not commit.Thirteen-year-old fledgling writer Briony Tallis irrevocably changes the course of several lives when she accuses her older sister's lover of a crime he did not commit.Thirteen-year-old fledgling writer Briony Tallis irrevocably changes the course of several lives when she accuses her older sister's lover of a crime he did not commit.Thirteen-year-old fledgling writer Briony Tallis irrevocably changes the course of several lives when she accuses her older sister's lover of a crime he did not commit.Thirteen-year-old fledgling writer Briony Tallis irrevocably changes the course of several lives when she accuses her older sister's lover of a crime he did not commit."
            static let numberOfLines = 0
        }
        
        enum LabelsStackView {
            static let spacing: CGFloat = 8
            static let top: CGFloat = 12
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -40
            static let height: CGFloat = 26
        }
        
        enum ScrollView {
            static let top: CGFloat = 8
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -16
        }
        
        enum FontSize {
            static let labelSize: CGFloat = 20
            static let aboutMovieLabelSize: CGFloat = 16
            static let movieDescriptionSize: CGFloat = 14
        }
    }
}

