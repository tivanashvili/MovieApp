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
    var collectionView: UICollectionView?
    var animateCollectionView = true
    
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
        let normalImage = UIImage(named: "Filter")
        let selectedImage = UIImage(named: "SelectedFilter")
        
        setImage(normalImage, for: .normal)
        setImage(selectedImage, for: .selected)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func buttonTapped() {
        isSelected.toggle()
        delegate?.didToggleFilterSection()
        
        collectionView?.isHidden = !isSelected
        
        if isSelected {
            let selectedImage = UIImage(named: "selectedFilter")
            setImage(selectedImage, for: .normal)
        } else {
            let normalImage = UIImage(named: "Filter")
            setImage(normalImage, for: .normal)
        }
        
        if animateCollectionView {
                 UIView.animate(withDuration: 0.5) {
                     self.collectionView?.alpha = self.isSelected ? 1.0 : 0.0
                 }
             }
    }
}

