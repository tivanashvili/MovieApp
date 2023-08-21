//
//  MovieTrailerViewController.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 25.07.23.
//

import UIKit
import AVFoundation

final class MovieTrailerViewController: UIViewController {
    
    // MARK: Properties
    private let videoURL: URL
    private let avPlayer = AVPlayer()
    private var isPlaying = false
    
    // MARK: Components
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.ButtonImages.backButton, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let videoPlayerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.ViewProperties.cornerRadius
        view.backgroundColor = Constants.ViewProperties.backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.ButtonTitles.playButton, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let slider: UISlider = {
        let slider = UISlider()
        slider.backgroundColor = .black
        slider.thumbTintColor = Constants.Slider.thumbTintColor
        slider.setMinimumTrackImage(Constants.Slider.minimumTrackImage, for: .normal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.ButtonImages.minusButton, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.ButtonImages.plusButton, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Init
    init(videoURL: URL) {
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setup()
        setupPlayer()
    }
    
    // MARK: Setup
    private func setup() {
        setupVideoPlayerViewConstraints()
        setupMinusButtonConstraints()
        setupPlusButtonConstraints()
        setupSliderConstraints()
        setupPlayPauseButtonConstraints()
        setupBackButtonConstraints()
        setupButtonActions()
    }
    
    private func setupButtonActions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    private func setupVideoPlayerViewConstraints() {
        view.addSubview(videoPlayerView)
        NSLayoutConstraint.activate([
            videoPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.ViewProperties.leading),
            videoPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.ViewProperties.trailing),
            videoPlayerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.ViewProperties.top),
            videoPlayerView.heightAnchor.constraint(equalToConstant: Constants.ViewProperties.height)
        ])
    }
    
    private func setupPlayPauseButtonConstraints() {
        view.addSubview(playPauseButton)
        NSLayoutConstraint.activate([
            playPauseButton.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: Constants.PlayPauseButton.top),
            playPauseButton.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: Constants.PlayPauseButton.bottom),
            playPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupSliderConstraints() {
        view.addSubview(slider)
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Slider.leading),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.Slider.trailing),
            slider.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: Constants.Slider.top),
        ])
    }
    
    private func setupMinusButtonConstraints() {
        view.addSubview(minusButton)
        NSLayoutConstraint.activate([
            minusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.MinusButton.leading),
            minusButton.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: Constants.MinusButton.top)
        ])
    }
    
    private func setupPlusButtonConstraints() {
        view.addSubview(plusButton)
        NSLayoutConstraint.activate([
            plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.PlusButton.leading),
            plusButton.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: Constants.PlusButton.top)
        ])
    }
    
    private func setupBackButtonConstraints() {
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.BackButton.trailing),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.BackButton.top)
        ])
    }
    
    // MARK: Player Setup
    private func setupPlayer() {
        let playerItem = AVPlayerItem(url: videoURL)
        avPlayer.replaceCurrentItem(with: playerItem)
        
        let playerLayer = AVPlayerLayer(player: avPlayer)
        playerLayer.frame.size.width = Constants.Video.width
        playerLayer.frame.size.height = Constants.Video.height
        videoPlayerView.clipsToBounds = true
        playerLayer.cornerRadius = Constants.Video.cornerRadius
        videoPlayerView.layer.addSublayer(playerLayer)
        playerLayer.videoGravity = .resizeAspectFill
        
        avPlayer.addPeriodicTimeObserver(forInterval: CMTime(seconds: Constants.Video.cmTime, preferredTimescale: Constants.Video.preferredTimescale), queue: .main) { [weak self] time in
            self?.updateSliderValue(with: time)
        }
    }
    
    @objc private func playPauseButtonTapped() {
        if isPlaying {
            avPlayer.pause()
            playPauseButton.setTitle(Constants.ButtonTitles.playButton, for: .normal)
            playPauseButton.setImage(nil, for: .normal)
        } else {
            avPlayer.play()
            playPauseButton.setTitle("", for: .normal)
            playPauseButton.setImage(Constants.ButtonImages.pauseButton, for: .normal)
        }
        isPlaying.toggle()
    }
    
    @objc private func minusButtonTapped() {
        seek(to: avPlayer.currentTime() - CMTime(seconds: Constants.Video.seconds, preferredTimescale: Constants.Video.preferredTimescale))
    }
    
    @objc private func plusButtonTapped() {
        seek(to: avPlayer.currentTime() + CMTime(seconds: Constants.Video.seconds, preferredTimescale: Constants.Video.preferredTimescale))
    }
    
    @objc private func sliderValueChanged() {
        let time = CMTime(seconds: Double(slider.value) * (avPlayer.currentItem?.duration.seconds ?? Constants.Video.cmTime), preferredTimescale: Constants.Video.preferredTimescale)
        seek(to: time)
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func seek(to time: CMTime) {
        avPlayer.seek(to: time)
    }
    
    private func updateSliderValue(with time: CMTime) {
        let totalTime = avPlayer.currentItem?.duration ?? CMTime(seconds: Constants.Video.cmTime, preferredTimescale: Constants.Video.preferredTimescale)
        let progress = Float(time.seconds / totalTime.seconds)
        slider.value = progress
    }
}

extension MovieTrailerViewController {
    enum Constants {
        enum ButtonImages {
            static let backButton = UIImage(named: "x")
            static let pauseButton = UIImage(named: "pause")
            static let minusButton = UIImage(named: "minus")
            static let plusButton = UIImage(named: "plus")
        }
        
        enum ViewProperties {
            static let cornerRadius: CGFloat = 12
            static let backgroundColor = UIColor(hex: "1C1C1C")
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -16
            static let top: CGFloat = 86
            static let height: CGFloat = 196
        }
        
        enum ButtonTitles {
            static let playButton = "Play"
        }
        
        enum Slider {
            static let backgroundColor = UIColor.black
            static let thumbTintColor = UIColor(hex: "F5C518")
            static let minimumTrackImage = UIImage(named: "slider")
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -16
            static let top: CGFloat = 60
        }
        
        enum PlayPauseButton {
            static let top: CGFloat = 20
            static let bottom: CGFloat = -20
        }
        
        enum PlusButton {
            static let leading: CGFloat = -72
            static let top: CGFloat = 20
        }
        
        enum MinusButton {
            static let leading: CGFloat = 72
            static let top: CGFloat = 20
        }
        
        enum BackButton {
            static let trailing: CGFloat = -16
            static let top: CGFloat = 34
        }
        
        enum Video {
            static let width: CGFloat = 386
            static let height: CGFloat = 196
            static let cornerRadius: CGFloat = 12
            static let preferredTimescale: Int32 = 1
            static let seconds: Double = 10
            static let cmTime: Double = 1
        }
    }
}
