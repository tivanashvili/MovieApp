//
//  FilterButton.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 17.07.23.
//

import UIKit

protocol FilterButtonDelegate: AnyObject {
    func didToggleFilterSection()
}

final class FilterButton: UIButton {
    
    weak var delegate: FilterButtonDelegate?
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setUp() {
        let normalImage = Constants.normalImage
        
        setImage(normalImage, for: .normal)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func buttonTapped() {
        isSelected.toggle()
        delegate?.didToggleFilterSection()
        
        if isSelected {
            let selectedImage = UIImage(named: "selectedFilter")
            setImage(selectedImage, for: .normal)
        } else {
            let normalImage = UIImage(named: "Filter")
            setImage(normalImage, for: .normal)
        }
    }
}

extension FilterButton {
    enum Constants {
        static let normalImage = UIImage(named: "Filter")
        static let selectedImage = UIImage(named: "selectedFilter")
    }
}
