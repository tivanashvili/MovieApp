//
//  UIColor + Extension.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 17.07.23.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        guard cString.count == 6 else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1.0)
            return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  
                  alpha: CGFloat(1.0)
                  
        )
    }
}

