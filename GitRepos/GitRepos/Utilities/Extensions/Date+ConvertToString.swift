//
//  Date+ConvertToString.swift
//  GitRepos
//
//  Created by Leon Horvath on 11/02/2024.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
}
