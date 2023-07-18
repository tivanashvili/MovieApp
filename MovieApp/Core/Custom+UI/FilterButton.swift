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
        setImage(UIImage(named: "Filter"), for: .normal)
        setImage(UIImage(named: "SelectedFilter"), for: .selected)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func buttonTapped() {
        isSelected.toggle()
        delegate?.didToggleFilterSection()
    }
}