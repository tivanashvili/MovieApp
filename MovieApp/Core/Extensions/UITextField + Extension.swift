//
//  UITextField + Extension.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 17.07.23.
//

import UIKit

extension UITextField {
    func setPlaceholderColor(_ color: UIColor) {
        guard let placeholder = self.placeholder else {
            return
        }
        
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
    }
}
