//
//  SettingsViewModel.swift
//  StudyTimer
//
//  Created by Jaden Creech on 6/15/25.
//

import Foundation
import AVFoundation


class SettingsViewModel: ObservableObject {
    @Published var settings: Settings = Settings()
    @Published var studyMins: String = "25"
    @Published var shortBreakMins: String = "5"
    @Published var longBreakMins: String = "10"
    @Published var longBreakIntv: String = "2"
    @Published var studyInc = false
    @Published var studyDec = false
    @Published var shortInc = false
    @Published var shortDec = false
    @Published var longInc = false
    @Published var longDec = false
    @Published var longIntvInc = false
    @Published var longIntvDec = false
    @Published var showColorPickerStudy = false
    @Published var showColorPickerShort = false
    @Published var showColorPickerLong = false
    @Published var selectedColor: Int = 0
    @Published var notificationInc = false
    @Published var notificationDec = false
    @Published var showSettingsAlert = false
    
    func updateSettings(newSettings: Settings) {
            self.settings = newSettings
    }
    
    func getMode() -> Int {
        return settings.currentMode
    }
    
    func setMode(mode: Int) {
        settings.currentMode = mode
    }
    
    func setStudyColor(hex: Int) {
        settings.modeColors[0] = hex
    }
    
    func setShortBreakColor(hex: Int) {
        settings.modeColors[1] = hex
    }
    
    func setLongBreakColor(hex: Int) {
        settings.modeColors[2] = hex
    }
    
    func getModeTime(mode: Int) -> Float {
        return settings.modeTimes[mode]
    }
    
    func setModeTime(mode: Int, time: Float) {
        settings.modeTimes[mode] = time
    }
    
    func isStudyTime() -> Bool {
        return settings.currentMode == 0
    }
    func isShortBreak() -> Bool {
        return settings.currentMode == 1
    }
    func isLongBreak() -> Bool {
        return settings.currentMode == 2
    }
    
  
    func nextMode() {
        
        if(isStudyTime()) {
            
            if(settings.breakCount == settings.longBreakIntv) {
                setMode(mode: 2)
                settings.breakCount = 0
            }
            else if (settings.breakCount < settings.longBreakIntv) {
                setMode(mode: 1)
                settings.breakCount += 1
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
        settings.longBreakIntv = intv
    }
    
    func getColors() -> [Int] {
        Settings.allColors
    }
    
    func getAutoStartBreaks() -> Bool {
        return settings.autoStartBreaks
    }
    
    func incrementButtonAction(mode: Int) {
        
        if mode == 0 {
            studyMins = incrementFormattedNumericString(numericString: studyMins) ?? studyMins
            setModeTime(mode: 0, time: Float(studyMins) ?? 25)
            studyInc = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.studyInc = false
            }
            
        }
        else if mode == 1 {
            shortBreakMins = incrementFormattedNumericString(numericString: shortBreakMins) ?? shortBreakMins
            setModeTime(mode: 1, time: Float(shortBreakMins) ?? 5)
            shortInc = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.shortInc = false
            }
            
        }
        else if mode == 2 {
            longBreakMins = incrementFormattedNumericString(numericString: longBreakMins) ?? longBreakMins
            setModeTime(mode: 2, time: Float(longBreakMins) ?? 10)
            longInc = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.longInc = false
            }
        }
        else if mode == 3 {
            if(settings.notificationTime <= 90){
                settings.notificationTime += 1
                notificationInc = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.notificationInc = false
                }
            }
                
        }
       
        
        AudioServicesPlaySystemSound(1104)
    }
    
    func decrementButtonAction(mode: Int) {
        
        if mode == 0 {
            studyMins = decrementFormattedNumericString(numericString: studyMins) ?? studyMins
            setModeTime(mode: 0, time: Float(studyMins) ?? 25)
            studyDec = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.studyDec = false
            }
        }
        else if mode == 1 {
            shortBreakMins = decrementFormattedNumericString(numericString: shortBreakMins) ?? shortBreakMins
            setModeTime(mode: 1, time: Float(shortBreakMins) ?? 5)
            shortDec = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.shortDec = false
            }
        }
        else if mode == 2 {
            longBreakMins = decrementFormattedNumericString(numericString: longBreakMins) ?? longBreakMins
            setModeTime(mode: 2, time: Float(longBreakMins) ?? 10)
            longDec = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.longDec = false
            }
        } else if mode == 3 {
            if settings.notificationTime > 1 {
                settings.notificationTime -= 1
                notificationDec = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.notificationDec = false
                }
            }
        }
        
        AudioServicesPlaySystemSound(1104)
    }
    private func incrementFormattedNumericString(numericString:String, increment by:Int=1) -> String? {
        
        guard let numericValue = Int(numericString) else {
            return nil }
        
        if(numericValue == 90) {
            AudioServicesPlaySystemSound(1104)
            return String(format: "%d", numericValue)
        }
       
        return String(format: "%d", numericValue + by)
    }

    private func decrementFormattedNumericString(numericString:String, decrement by:Int=1) -> String? {
        
        guard let numericValue = Int(numericString) else { return nil }
        
        if(numericValue == 1) {
            AudioServicesPlaySystemSound(1104)
            return String(format: "%d", numericValue)
            
        }
        return String(format: "%d", numericValue - by)
    }
    
    func incrementLongBreakIntv() {
        longBreakIntv = incrementFormattedNumericString(numericString: longBreakIntv) ?? longBreakIntv
        setLongBreakIntv(intv: Int(longBreakIntv) ?? 2)
        AudioServicesPlaySystemSound(1104)
        longIntvInc = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.longIntvInc = false
        }
    }
    
    func decrementLongBreakIntv() {
        longBreakIntv = decrementFormattedNumericString(numericString: longBreakIntv) ?? longBreakIntv
        setLongBreakIntv(intv: Int(longBreakIntv) ?? 2)
        AudioServicesPlaySystemSound(1104)
        longIntvDec = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.longIntvDec = false
        }
    }
    
    

}
