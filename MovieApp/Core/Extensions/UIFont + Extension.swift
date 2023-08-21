//
//  UIFont + Extension.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 11.08.23.
//

import Foundation
import UIKit

extension UIFont {
    
    enum CustomFont {
        case semiBold
        case regular
        case medium
        case light
        case extraBold
        case bold
    }
    
    
    static func customFont(_ fontType: CustomFont, size: CGFloat) -> UIFont {
        var fontName = ""
        switch fontType {
        case .semiBold:
            fontName = "Montserrat-SemiBold"
        case .regular:
            fontName = "Montserrat-Regular"
        case .medium:
            fontName = "Montserrat-Medium"
        case .light:
            fontName = "Montserrat-Light"
        case .extraBold:
            fontName = "Montserrat-ExtraBold"
        case .bold:
            fontName = "Montserrat-Bold"
        }
        
        if let customFont = UIFont(name: fontName, size: size) {
            return customFont
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
}

