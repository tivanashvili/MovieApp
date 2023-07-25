//
//  MovieTrailerViewController.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 25.07.23.
//

import UIKit
import AVFoundation

class MovieTrailerViewController: UIViewController {

    // MARK: Properties
    private let videoURL: URL
    private let avPlayer = AVPlayer()
    private var isPlaying = false

    // MARK: UI Components
    private let videoPlayerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor(hex: "1C1C1C")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "pause"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let slider: UISlider = {
        let slider = UISlider()
        slider.backgroundColor = .black
        slider.thumbTintColor = UIColor(hex: "F5C518")
        slider.setMinimumTrackImage(UIImage(named: "slider"), for: .normal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    private let minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: Initialization
    init(videoURL: URL) {
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupPlayer()
    }

    // MARK: UI Setup
    private func setup() {
        setupVideoPlayerViewConstraints()
        setupMinusButtonConstraints()
        setupPlusButtonConstraints()
        setupSliderConstraints()
        setupPlayPauseButtonConstraints()
    }
    
    private func setupButtonActions() {
        playPauseButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    private func setupVideoPlayerViewConstraints() {
        view.addSubview(videoPlayerView)
        NSLayoutConstraint.activate([
            videoPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            videoPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            videoPlayerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 86),
            videoPlayerView.heightAnchor.constraint(equalToConstant: 196)
        ])
    }
    
    private func setupPlayPauseButtonConstraints() {
        view.addSubview(playPauseButton)
        NSLayoutConstraint.activate([
            playPauseButton.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: 20),
            playPauseButton.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -20),
            playPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupSliderConstraints() {
        view.addSubview(slider)
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            slider.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: 60),
        ])
    }

    private func setupMinusButtonConstraints() {
        view.addSubview(minusButton)
        NSLayoutConstraint.activate([
            minusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 72),
            minusButton.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: 20)
        ])
    }

    private func setupPlusButtonConstraints() {
        view.addSubview(plusButton)
        NSLayoutConstraint.activate([
            plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -72),
            plusButton.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: 20)
        ])
    }

    // MARK: Player Setup
    private func setupPlayer() {
        let playerItem = AVPlayerItem(url: videoURL)
        avPlayer.replaceCurrentItem(with: playerItem)

        let playerLayer = AVPlayerLayer(player: avPlayer)
        playerLayer.frame = videoPlayerView.bounds
        videoPlayerView.layer.addSublayer(playerLayer)
    }

    @objc private func playPauseButtonTapped() {
        if isPlaying {
            avPlayer.pause()
            playPauseButton.setTitle("Play", for: .normal)
        } else {
            avPlayer.play()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        isPlaying.toggle()
    }

    @objc private func minusButtonTapped() {
        seek(to: avPlayer.currentTime() - CMTime(seconds: 10, preferredTimescale: 1))
    }

    @objc private func plusButtonTapped() {
        seek(to: avPlayer.currentTime() + CMTime(seconds: 10, preferredTimescale: 1))
    }

    @objc private func sliderValueChanged() {
        let time = CMTime(seconds: Double(slider.value), preferredTimescale: 1)
        seek(to: time)
    }

    // MARK: Helper method to handle seeking
    private func seek(to time: CMTime) {
        avPlayer.seek(to: time)
    }
}
