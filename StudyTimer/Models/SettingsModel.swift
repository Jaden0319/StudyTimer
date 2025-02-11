//
//  SettingsModel.swift
//  StudyTimer
//
//  Created by Jaden Creech on 2/10/25.
//

import Foundation


extension BaseView {
    
    final class SettingsModel: ObservableObject {
        
        private final var modes: [String: Int] = ["StudyTime": 0, "ShortBreak": 1, "LongBreak": 2]
        @Published var mode_colors: [Int] = [0xE84D4D, 0x2eaace, 0x11669c]
        @Published var mode_times: [Float] = [25.0, 5.0, 10.0]
        @Published var backgroundColor: Int = 0xE84D4D
        
        @Published var mode: Int = 0 {
            didSet {
                backgroundColor = mode_colors[mode]
            }
        }
        
        @Published var longBreakIntv: Int = 4
        @Published var breakCount: Int = 0
        
        
    }
}
