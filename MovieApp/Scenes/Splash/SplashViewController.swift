//
//  SplashViewController.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 17.07.23.
//

import UIKit

final class SplashViewController: UIViewController {
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = Constants.LaunchScreenImage.image
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageConstraints()
        view.backgroundColor = .black
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigateToMainScreen()
        }
    }
    
    func navigateToMainScreen() {
        let homeViewController = HomeViewController()

        homeViewController.navigationItem.setHidesBackButton(true, animated: false)
        
        navigationController?.pushViewController(homeViewController, animated: false)
    }
    
    private func setupImageConstraints() {
        view.addSubview(image)
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

extension SplashViewController {
    enum Constants {
        enum LaunchScreenImage{
            static let image = UIImage(named: "IMDB_Logo")
        }
    }
}
