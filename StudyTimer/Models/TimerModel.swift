//
//  TimerModel.swift
//  StudyTimer
//
//  Created by Jaden Creech on 2/7/25.
//

import Foundation

extension BaseView {
    
    final class TimerModel: ObservableObject {
        @Published var isActive = false
        @Published var showingAlert = false
        @Published var time: String = "1:00"
        @Published var minutes: Float = 1.0 {
            didSet {
                self.time = "\(Int(minutes)):00"
            }
        }
        
        private var initialTime = 0
        private var endDate = Date()
        private var remainingTime: TimeInterval = 0
        
        
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
            
            self.isActive = true
            self.remainingTime = 0
         
        }
        
        func pause() {
           
            guard isActive else { return }
                let now = Date()
                remainingTime = endDate.timeIntervalSince(now)
                isActive = false 
        }
        
        func reset() {
            self.minutes = Float(initialTime)
            self.isActive = false
            self.time = "\(Int(minutes)):00"
            self.remainingTime = 0
            
        }
        
        func updateCountdown() {
            guard isActive else {return}
            let now = Date()
            let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            if(diff <= 0) { //When timer ends
                self.isActive = false
                self.time = "0:00"
                self.showingAlert = true
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
        
        
    }
}

