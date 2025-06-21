//
//  WeeklyUsageModel.swift
//  StudyTimer
//
//  Created by Jaden Creech on 6/20/25.
//

import Foundation
import FirebaseFirestore

struct WeeklyUsage: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var nickname: String
    var weekOfYear: Int
    var year: Int
    var totalSeconds: Int
}
