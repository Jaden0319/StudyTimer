//
//  StatsViewModel.swift
//  StudyTimer
//
//  Created by Jaden Creech on 6/27/25.
//

import Foundation

class StatsViewModel: ObservableObject {
    
    enum SummaryTab: String, CaseIterable {
        case summary = "Summary"
        case ranking = "Ranking"
    }
    
    @Published var selectedTab: SummaryTab = .summary

}
