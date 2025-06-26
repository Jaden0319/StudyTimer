//
//  SummaryViewModel.swift
//  StudyTimer
//
//  Created by Jaden Creech on 6/26/25.
//

import Foundation
import Firebase
import FirebaseAuth

class SummaryViewModel: ObservableObject {
    
    @Published var weeklyUsage: [DailyUsage] = []
    @Published var activitySummary: ActivitySummary = ActivitySummary(
        id: nil,
        userId: "",
        totalSeconds: 0,
        lastDayActive: Date(),
        dayStreak: 0,
        daysAccessed: 0
    )
    
    @Published var selectedWeekOfYear: Int
    @Published var currentWeekOfYear: Int
    @Published var selectedYear: Int
    
    var weekLabel: String {
        let calendar = Calendar.current
        let currentWeek = calendar.component(.weekOfYear, from: Date())

        if selectedWeekOfYear == currentWeek {
            return "This Week"
        }

        var components = DateComponents()
        components.weekOfYear = selectedWeekOfYear
        components.yearForWeekOfYear = selectedYear

        if let date = calendar.date(from: components) {
            let formatter = DateFormatter()
            formatter.dateFormat = "(E) dd-MMM"
            return formatter.string(from: date)
        }

        return "Week \(selectedWeekOfYear)"
    }

    init() {
        let now = Date()
        let calendar = Calendar.current
        self.selectedWeekOfYear = calendar.component(.weekOfYear, from: now)
        self.selectedYear = calendar.component(.yearForWeekOfYear, from: now)
        self.currentWeekOfYear = calendar.component(.weekOfYear, from: now)
    }
    
    
    func fetchWeeklyUsage(id: String?) {
        guard let userId = id else { return }

        let db = Firestore.firestore()
        var calendar = Calendar.current
        calendar.firstWeekday = 1 // Sunday

        var components = DateComponents()
        components.weekOfYear = selectedWeekOfYear
        components.yearForWeekOfYear = selectedYear

        guard let startOfWeek = calendar.date(from: components),
              let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek) else { return }

        db.collection("users")
            .document(userId)
            .collection("dailyUsage")
            .whereField("date", isGreaterThanOrEqualTo: Timestamp(date: startOfWeek))
            .whereField("date", isLessThan: Timestamp(date: endOfWeek))
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching weekly usage: \(error)")
                    return
                }

                let entries = snapshot?.documents.compactMap {
                    try? $0.data(as: DailyUsage.self)
                } ?? []

                // Normalize with all 7 days
                var result: [DailyUsage] = []
                let usageByDate = Dictionary(uniqueKeysWithValues: entries.map {
                    (Calendar.current.startOfDay(for: $0.date), $0)
                })

                for offset in 0..<7 {
                    if let date = calendar.date(byAdding: .day, value: offset, to: startOfWeek) {
                        result.append(usageByDate[date] ?? DailyUsage(id: nil, userId: userId, totalSeconds: 0, date: date))
                    }
                }

                DispatchQueue.main.async {
                    self.weeklyUsage = result.sorted { $0.date < $1.date }
                }
            }
    }

    
    func previousWeek() {
        if selectedWeekOfYear > 1 {
            selectedWeekOfYear -= 1
        }
    }

    func nextWeek() {
        if selectedWeekOfYear < currentWeekOfYear {
            selectedWeekOfYear += 1
        }
    }
    
    func fetchActivitySummary(id: String?) {
        guard let userId = id else { return }

        let db = Firestore.firestore()
        let summaryRef = db
            .collection("users")
            .document(userId)
            .collection("activitySummary")
            .document("summary")

        summaryRef.getDocument { document, error in
            if let error = error {
                print("Error fetching activity summary: \(error.localizedDescription)")
                return
            }

            guard let document = document, document.exists else {
                print("No activity summary found.")
                return
            }

            do {
                if let summary = try document.data(as: ActivitySummary?.self) {
                    DispatchQueue.main.async {
                        self.activitySummary = summary
                    }
                }
            } catch {
                print("Error decoding activity summary: \(error.localizedDescription)")
            }
        }
    }
    
    func secondsToHoursOneDecimal(_ seconds: Double) -> Double {
        let hours = seconds / 3600.0
        return floor(hours * 10) / 10.0
    }
  
}
