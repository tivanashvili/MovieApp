//
//  SearchBar.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 17.07.23.
//

import UIKit

protocol SearchBarDelegate: AnyObject {
    func textFieldStartTyping()
}

final class SearchBar: UIView {
    
    private let searchIcon: UIImageView = {
        let image = UIImageView()
        image.image = Constants.SearchIcon.image
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.font = Constants.SearchTextField.textFont
        textField.placeholder = Constants.SearchTextField.text
        textField.textColor = .white
        textField.delegate = self
        textField.setPlaceholderColor(Constants.SearchTextField.textColor)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    weak var delegate: SearchBarDelegate?
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupSearchTextFieldConstraints()
        setupSearchIconConstraints()
        setupViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchIconConstraints() {
        searchTextField.addSubview(searchIcon)
        NSLayoutConstraint.activate([
            searchIcon.topAnchor.constraint(equalTo: topAnchor, constant: Constants.SearchIcon.top),
            searchIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.SearchIcon.leading)
        ])
    }
    
    private func setupSearchTextFieldConstraints() {
        addSubview(searchTextField)
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: topAnchor, constant: Constants.SearchTextField.top),
            searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.SearchTextField.bottom),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.SearchTextField.leading),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 36),
            widthAnchor.constraint(equalToConstant: 299)
        ])
    }    
}

extension SearchBar: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldStartTyping()
    }
}

private extension SearchBar {
    enum Constants {
        enum SearchTextField {
            static let text = "Search"
            static let textFont = UIFont(name: "Montserrat-VariableFont_wght", size: 16)
            static let textColor = UIColor(hex: "A5A5A5")
            static let top: CGFloat = 9
            static let bottom: CGFloat = -9
            static let leading: CGFloat = 44
        }
        enum SearchIcon {
            static let image = UIImage(named: "searchImage")
            static let top: CGFloat = 11
            static let leading: CGFloat = 24
        }
    }
}
