//
//  SettingsModel.swift
//  StudyTimer
//
//  Created by Jaden Creech on 2/10/25.
//

import Foundation

    final class SettingsModel: ObservableObject {
        
        private final var modes: [String: Int] = ["StudyTime": 0, "ShortBreak": 1, "LongBreak": 2]
        @Published var mode_colors: [Int] = [0xE84D4D, 0x2eaace, 0x11669c]
        @Published private var mode_times: [Float] = [25.0, 5.0, 10.0]
        @Published var backgroundColor: Int = 0xE84D4D
        
        @Published private var mode: Int = 0 {
            didSet {
                backgroundColor = mode_colors[mode]
            }
        }
        
        @Published var longBreakIntv: Int = 2
        @Published var breakCount: Int = 0
        
        func setMode(mode: Int) {
            self.mode = mode
        }
        
        func setStudyColor(hex: Int) {
            self.mode_colors[0] = hex
        }
        
        func setShortBreakColor(hex: Int) {
            self.mode_colors[1] = hex
        }
        
        func setLongBreakColor(hex: Int) {
            self.mode_colors[2] = hex
        }
        
        func getModeTime(mode: Int) -> Float {
            return self.mode_times[mode]
        }
        
        func setModeTime(mode: Int, time: Float) {
            self.mode_times[mode] = time
        }
        
        func isStudyTime() -> Bool {
            return self.mode == 0
        }
        func isShortBreak() -> Bool {
            return self.mode == 1
        }
        func isLongBreak() -> Bool {
            return self.mode == 2
        }
        
        func nextMode() {
            
            if(isStudyTime()) {
                
                if(breakCount == longBreakIntv) {
                    setMode(mode: 2)
                    breakCount = 0
                }
                else if (breakCount < longBreakIntv) {
                    setMode(mode: 1)
                    breakCount += 1
                }
            }
            else if(isShortBreak()) {
                setMode(mode: 0)
            }
            else if(isLongBreak()) {
                setMode(mode: 0)
            }
        }
        
    }
