//
//  LabelsContainerView.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 24.07.23.
//

import UIKit

class LabelsContainerView: UIView {

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        layer.cornerRadius = 12
        backgroundColor = UIColor(hex: "1C1C1C")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var labelText: String? {
        get { return label.text }
        set { label.text = newValue }
    }

    var image: UIImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
    }

    private func setupView() {
        setupImageViewConstraints()
        setupLabelConstraints()
    }
    
    private func setupLabelConstraints() {
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func setupImageViewConstraints() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  10),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            imageView.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
}

