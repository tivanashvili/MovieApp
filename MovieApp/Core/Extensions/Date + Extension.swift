//
//  Date + Extension.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 22.08.23.
//

import Foundation

extension Date {
    static func formatCutomDate(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return "\(year)"
        }
        return ""
    }
}
