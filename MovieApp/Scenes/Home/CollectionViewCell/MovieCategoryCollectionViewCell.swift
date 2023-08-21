//
//  MovieCategoryCollectionViewCell.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 17.07.23.
//

import UIKit

final class MovieCategoryCollectionViewCell: UICollectionViewCell {
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.CellLabel.font
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = Constants.CellLabel.numberOfLines
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
        layer.cornerRadius = Constants.CellLabel.cornerRadius
        layer.borderWidth = Constants.CellLabel.cornerWidth
        layer.borderColor = isSelectedCell ? UIColor.clear.cgColor : UIColor.white.cgColor
    }
    
    var isSelectedCell: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    private func updateAppearance() {
        if isSelectedCell {
            backgroundColor = Constants.CellLabel.backgroundColor
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
            cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.CellLabel.top),
            cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.CellLabel.leading),
            cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.CellLabel.bottom)
        ])
    }
    
    func configure(with genreCategory: GenreCategory) {
        cellLabel.text = genreCategory.title
        cellLabel.sizeToFit()
        let cellWidth = cellLabel.frame.width + Constants.CellLabel.cellWidth
        let cellSize = CGSize(width: cellWidth, height: Constants.CellLabel.cellHeight)
        contentView.frame.size = cellSize
    }
}

extension MovieCategoryCollectionViewCell {
    enum Constants {
        enum CellLabel {
            static let font = UIFont(name: "Montserrat-VariableFont_wght.ttf", size: 10)
            static let numberOfLines = 1
            static let backgroundColor = UIColor(hex: "F5C518")
            static let top: CGFloat = 4
            static let leading: CGFloat = 12
            static let bottom: CGFloat = -4
            static let cornerWidth: CGFloat = 1
            static let cornerRadius: CGFloat = 12
            static let cellWidth: CGFloat = 24
            static let cellHeight: CGFloat = 26
        }
    }
}
