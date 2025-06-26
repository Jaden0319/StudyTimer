//
//  DailyUsageModel.swift
//  StudyTimer
//
//  Created by Jaden Creech on 6/25/25.
//

import Foundation
import FirebaseFirestore

struct DailyUsage: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var totalSeconds: Double
    var date: Date
}
