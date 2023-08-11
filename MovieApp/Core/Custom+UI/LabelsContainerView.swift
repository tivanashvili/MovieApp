//
//  LabelsContainerView.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 24.07.23.
//

import UIKit

final class LabelsContainerView: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = Constants.labelTextColor
        label.font = Constants.labelFont
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
        layer.cornerRadius = Constants.cornerRadius
        backgroundColor = Constants.backgroundColor
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
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.labelLeading),
            label.topAnchor.constraint(equalTo: topAnchor, constant: Constants.labelTop),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.labelBottom),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.labelTrailing)
        ])
    }
    
    private func setupImageViewConstraints() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  Constants.imageLeading),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.imageBottom),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.imageTop),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)
        ])
    }
}

extension LabelsContainerView {
    enum Constants {
        static let labelTextColor: UIColor = .white
        static let labelFont: UIFont = .boldSystemFont(ofSize: 14)
        static let cornerRadius: CGFloat = 12
        static let backgroundColor: UIColor = UIColor(hex: "1C1C1C")
        static let labelLeading: CGFloat = 4
        static let labelTop: CGFloat = 4
        static let labelBottom: CGFloat = -4
        static let labelTrailing: CGFloat = -10
        static let imageLeading: CGFloat = 10
        static let imageBottom: CGFloat = -7
        static let imageTop: CGFloat = 7
        static let imageHeight: CGFloat = 12
    }
}
