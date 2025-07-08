//
//  StatsView.swift
//  StudyTimer
//
//  Created by Jaden Creech on 6/20/25.
//

import Foundation
import SwiftUI

struct StatsView: View {
    @EnvironmentObject var baseVM: BaseViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject private var statsVM: StatsViewModel = StatsViewModel()

    var body: some View {
        VStack(spacing: 12) {
            // Header with Back Button and Title
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.pink)
                        .font(.system(size: 16, weight: .semibold))
                    
                }
                .padding(.leading)
                
              
                Spacer()

                Text("Statistics")
                    .font(Font.custom("Avenir-Medium", size: 18))
                    .bold()
                

                Spacer()

                // Empty space to balance the back button
                Spacer()
                    .frame(width: 30)
            }
            .padding(.top, 8)

            // Tab Selector
            HStack(spacing: 0) {
                ForEach(StatsViewModel.SummaryTab.allCases, id: \.self) { tab in
                    Button(action: {
                        statsVM.selectedTab =  tab
                    }) {
                        Text(tab.rawValue)
                            .font(.system(size: 13, weight: .semibold))
                            .frame(maxWidth: .infinity, minHeight: 25)
                            .padding(.vertical, 4)
                            .background(statsVM.selectedTab == tab ? Color.pink.opacity(0.2) : Color.clear)
                            .foregroundColor(statsVM.selectedTab == tab ? .pink : .gray)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.pink, lineWidth: 1)
                    )
                }
            }
            .padding(.horizontal)

            // Content View Switch
            switch statsVM.selectedTab {
            case .summary:
                SummaryView().environmentObject(baseVM)
            case .ranking:
                LeaderboardView().environmentObject(baseVM)
            }
        }
    }
}

#Preview {
    StatsView()
        .environmentObject(BaseViewModel())
}
