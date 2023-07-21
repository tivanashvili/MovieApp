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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = isSelectedCell ? UIColor.clear.cgColor : UIColor.white.cgColor
    }
    
    var isSelectedCell: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    private func updateAppearance() {
        if isSelectedCell {
            backgroundColor = UIColor(hex: "F5C518")
            layer.borderWidth = 0
            cellLabel.textColor = .black
        } else {
            backgroundColor = UIColor.clear
            layer.borderWidth = 1
            layer.borderColor = UIColor.white.cgColor
            cellLabel.textColor = .white
        }
    }
    
    private func setupCellLabelConstraints() {
        contentView.addSubview(cellLabel)
        NSLayoutConstraint.activate([
            cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
        ])
    }
    
    func configure(with category: String) {
        cellLabel.text = category
    }
}
