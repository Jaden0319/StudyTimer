//
//  SettingsModel.swift
//  StudyTimer
//
//  Created by Jaden Creech on 2/10/25.
//

import Foundation


extension BaseView {
    
    final class SettingsModel: ObservableObject {
        
        @Published var mode_color: [String: Int] = ["StudyTime": 0xE84D4D, "ShortBreak": 0x2eaace, "LongBreak": 0x11669c]
        @Published var mode_time: [String: Float] = ["StudyTime": 25.0, "ShortBreak": 5.0, "LongBreak": 10.0]
        @Published var backgroundColor: Int = 0xE84D4D
       
        @Published var mode: String = "StudyTime" {
            didSet {
                backgroundColor = mode_color[mode]!
                
            }
        }
        
        @Published var longBreakIntv: Int = 4
        @Published var breakCount: Int = 0
        
        
        
        
        
        
        
        
    }
}
