//
//  BaseViewModel.swift
//  StudyTimer
//
//  Created by Jaden Creech on 6/16/25.
//

import Foundation
import AVFoundation

class BaseViewModel: ObservableObject {
    
    @Published var timerIsActive = false
    @Published var timerShowingAlert = false
    @Published var time: String = "25:00"
    @Published var minutes: Float = 25.0 {
        didSet {
            self.time = "\(Int(minutes)):00"
        }
    }
    @Published var lastTime: Float = 0.0
    @Published var backgroundTicking: Bool = false
    var initialTime = 0
    var endDate = Date()
    var remainingTime: TimeInterval = 0
    var startTime: Float = 0
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    @Published var settingsModel: SettingsViewModel = SettingsViewModel()
    @Published var showingSettings = false
    
    @Published var startText: String = "Start"
    
    
    func setMinutes(mins: Float) {
        self.minutes = mins
    }
    
    func start(minutes: Float) {
        
        if remainingTime <= 0 {
            self.initialTime = Int(minutes)
            self.endDate = Date()
            self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: endDate)!
        }
        else {
            self.endDate = Date().addingTimeInterval(remainingTime)
        }
        
        self.timerIsActive = true
        self.remainingTime = 0
        
    }
    
    func pause() {
        
        guard timerIsActive else { return }
        let now = Date()
        remainingTime = endDate.timeIntervalSince(now)
        timerIsActive = false
    }
    
    func reset() {
        self.minutes = Float(initialTime)
        self.timerIsActive = false
        self.time = "\(Int(minutes)):00"
        self.remainingTime = 0
        
    }
    
    func updateCountdown() {
        guard timerIsActive else {return}
        let now = Date()
        let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
        
        if(diff <= 0) { //When timer ends
            self.timerIsActive = false
            self.time = "0:00"
            self.timerShowingAlert = true
            self.reset()
            //Where to add notifs
            return
        }
        
        let date = Date(timeIntervalSince1970: diff)
        let calander = Calendar.current
        let minutes = calander.component(.minute, from: date)
        let seconds = calander.component(.second, from: date)
        
        
        self.minutes = Float(minutes)
        self.time = String(format: "%d:%02d", minutes, seconds)
    }
    
    func openSettingsAndPauseTimer() {
        showingSettings = true
        pause()
        lastTime = settingsModel.getModeTime(mode: settingsModel.settings.currentMode)
    }
    
    func exitSettings() {
        showingSettings = false
        if(lastTime != settingsModel.getModeTime(mode: settingsModel.settings.currentMode)) {
            reset()
            minutes = settingsModel.getModeTime(mode: settingsModel.settings.currentMode)
        }
    }
    
    func modeClick(mode: Int) {
        settingsModel.setMode(mode: mode) //0: StudyTime 1: Short 2: long
        reset()
        minutes = settingsModel.getModeTime(mode: mode)
        settingsModel.settings.backgroundColor = settingsModel.settings.modeColors[mode]
    }
    
    func handleTimerUpdate() {
        
        updateCountdown()

        if(!timerIsActive) {
            startText = "Start"
        }
        
        if(!timerIsActive && timerShowingAlert) {
            
            reset()
            SoundManager.shared.playImportedSound(named: Settings.sounds[settingsModel.settings.alarmSound] ?? "defualt_alarm")
            let lastMode = settingsModel.settings.currentMode
            settingsModel.nextMode()
            timerShowingAlert = false
            minutes = settingsModel.getModeTime(mode: settingsModel.settings.currentMode)
            
            
            if(settingsModel.settings.autoStartStudy) {
                if(lastMode == 1 || lastMode == 2) {
                    start(minutes: minutes)
                    startText = "Pause"
                }
            }
            
            if(settingsModel.settings.autoStartBreaks) {
                if(lastMode == 0) {
                    start(minutes: minutes)
                    startText = "Pause"
                }
            }

            
        }
        
    }
    
    func startButtonClick() {
        if(!timerIsActive) {
            start(minutes: minutes)
            startText = "Pause"
        }
        else {
            pause()
            startText = "Start"
        }
        
        AudioServicesPlaySystemSound(1104)
    }
}
    

