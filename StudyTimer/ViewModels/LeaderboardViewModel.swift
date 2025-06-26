//
//  LeaderboardViewModel.swift
//  StudyTimer
//
//  Created by Jaden Creech on 6/20/25.
//

import Foundation
import AVFoundation
import Firebase
import FirebaseAuth

class LeaderboardViewModel: ObservableObject {
    @Published var entries: [WeeklyUsage] = []

    init() {
        fetchTopWeeklyUsage()
    }

    func fetchTopWeeklyUsage() {
        let db = Firestore.firestore()
        let now = Date()
        let calendar = Calendar.current
        let week = calendar.component(.weekOfYear, from: now)
        let year = calendar.component(.yearForWeekOfYear, from: now)

        db.collectionGroup("weeklyUsage")
            .whereField("weekOfYear", isEqualTo: week)
            .whereField("year", isEqualTo: year)
            .order(by: "totalSeconds", descending: true)
            .limit(to: 250)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching leaderboard: \(error.localizedDescription)")
                    return
                }

                let usageEntries: [WeeklyUsage] = snapshot?.documents.compactMap { doc in
                    try? doc.data(as: WeeklyUsage.self)
                } ?? []

                DispatchQueue.main.async {
                    self.entries = usageEntries
                    
                }
            }
    }
    func formatTimeHHMM(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        return String(format: "%d:%02d", hours, minutes)
    }
    
    
}
