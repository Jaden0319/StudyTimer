//
//  SettingsModel.swift
//  StudyTimer
//
//  Created by Jaden Creech on 2/10/25.
//




import Foundation

    final class SettingsModel: ObservableObject {
        
        final var modes: [Int: String] = [0: "StudyTime", 1: "Short Break", 2: "Long Break"]
        
        final var fonts: [String: String] = [
                "Default": "Avenir-Medium",
                "Fancy": "Snell Roundhand",
                "Cartoon": "Chalkboard SE",
                "Robot": "Menlo"
            ]
      
        @Published var timerFont: String = "Default"
        @Published private var mode_times: [Float] = [25.0, 5.0, 10.0]
        @Published var backgroundColor: Int = 0xE84D4D
        @Published var autoStartBreaks = false
        @Published var autoStartStudy = false
        private let allColors: [Int] = [0xE84D4D, 0x2eaace, 0x11669c, 0xF4D35E, 0xB388EB, 0xFFA07A, 0x8BC34A, 0xFFB34]
        
        @Published var mode_colors: [Int] = [0xE84D4D, 0x2eaace, 0x11669c] {
            didSet {
                backgroundColor = mode_colors[mode]
            }
        }
         
        
        @Published private var mode: Int = 0 {
            didSet {
                backgroundColor = mode_colors[mode]
            }
        }
        
        @Published var longBreakIntv: Int = 2
        @Published var breakCount: Int = 0
        
        
        
        func getMode() -> Int {
            return mode
        }
        
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
        
        func autoStartBreaksToggle() -> Void {
            autoStartBreaks.toggle()
        }
        
        func autoStartStudyToggle() -> Void {
            autoStartStudy.toggle()
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
        
        func setLongBreakIntv(intv: Int) {
            longBreakIntv = intv
        }
        
        func getColors() -> [Int] {
            return allColors
        }
        
    }
