//
//  MovieCategoryCollectionViewCell.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 17.07.23.
//

import UIKit

class MovieCategoryCollectionViewCell: UICollectionViewCell {
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-VariableFont_wght.ttf", size: 10)
        label.text = "Movies"
        label.textColor = .white
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCellLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellLabelConstraints() {
        contentView.addSubview(cellLabel)
        NSLayoutConstraint.activate([
            cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        ])
    }
    
    func configure(with category: String) {
        cellLabel.text = category
    }
}
