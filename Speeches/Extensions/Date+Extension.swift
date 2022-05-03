//
//  Date+Extension.swift
//  Speeches
//
//  Created by turu on 2022/05/03.
//

import Foundation

extension Date {
    var currentDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}
