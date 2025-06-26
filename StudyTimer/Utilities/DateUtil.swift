//
//  DateUtil.swift
//  StudyTimer
//
//  Created by Jaden Creech on 6/26/25.
//

import Foundation

extension Date {
    var weekdayAbbreviation: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: self)
    }
}
