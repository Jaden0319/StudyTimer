//
//  SummaryView.swift
//  StudyTimer
//
//  Created by Jaden Creech on 6/25/25.
//

import SwiftUI
import Charts


import SwiftUI
import Charts

struct SummaryView: View {
    
    @EnvironmentObject var baseVM: BaseViewModel
    @StateObject var summaryVM: SummaryViewModel = SummaryViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                // Section: Activity Summary Title
                Text("Activity Summary")
                    .font(Font.custom("Avenir-Medium", size: 16))
                    .bold()
                    .padding(.leading, 15)

                Divider()
                
                // Section: Summary Cards
                HStack(spacing: 15) {
                    SummaryCardView(icon: "clock.fill", value: "\(summaryVM.secondsToHoursOneDecimal(summaryVM.activitySummary.totalSeconds))", label: "hours focused")
                    SummaryCardView(icon: "calendar.badge.clock", value: "\(summaryVM.activitySummary.daysAccessed)", label: "days accessed")
                    SummaryCardView(icon: "flame.fill", value: "\(summaryVM.activitySummary.dayStreak)", label: "day streak")
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 20)

                Text("Focus Hours")
                    .font(Font.custom("Avenir-Medium", size: 16))
                    .bold()
                    .padding(.leading, 15)

                Divider()
                
                HStack {
                    Button(action: {
                        summaryVM.previousWeek()
                        summaryVM.fetchWeeklyUsage(id: baseVM.user.id)
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(summaryVM.selectedWeekOfYear == 1 ? .gray : .pink)
                    }.disabled(summaryVM.selectedWeekOfYear == 1)

                    Text(summaryVM.weekLabel)
                        .font(.headline)
                        .foregroundColor(.pink)
                        .padding(.horizontal, 12)

                    Button(action: {
                        summaryVM.nextWeek()
                        summaryVM.fetchWeeklyUsage(id: baseVM.user.id)
                    }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(summaryVM.selectedWeekOfYear == summaryVM.currentWeekOfYear ? .gray : .pink)
                    }.disabled(summaryVM.selectedWeekOfYear == summaryVM.currentWeekOfYear)
                    
                }
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.pink, lineWidth: 1.5)
                )
                .padding(.horizontal)
                
                Spacer()
                // Chart
                Chart {
                    ForEach(summaryVM.weeklyUsage) { entry in
                        BarMark(
                            x: .value("Day", entry.date.weekdayAbbreviation),
                            y: .value("Hours", entry.totalSeconds / 3600)
                        )
                        .foregroundStyle(.pink)
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .frame(maxWidth: .infinity)
                .frame(minHeight: 400, maxHeight: screenSize.height - 100)
                .padding(.horizontal, 10)
            }
            .padding(.bottom, 10)
        }
        .onAppear {
            if let userId = baseVM.user.id {
                summaryVM.fetchActivitySummary(id: userId)
                summaryVM.fetchWeeklyUsage(id: userId)
            }
        }
    }
}



private struct SummaryCardView: View {
    var icon: String
    var value: String
    var label: String
    let cardWidth = UIScreen.main.bounds.width / 3.9
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.pink)

            Text(value)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.pink)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
              

            Text(label)
                .font(Font.custom("Avenir-Medium", size: 13))
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.6)
                .foregroundColor(.pink)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(width: cardWidth, height: 85)
        .padding(.vertical, 16)
        .padding(.horizontal, 5)
        .background(Color.pink.opacity(0.1))
        .cornerRadius(16)
    }
}


#Preview {
    SummaryView()
        .environmentObject(BaseViewModel())


}
