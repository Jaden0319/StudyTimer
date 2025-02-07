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
        @Published var time: String = "20:00"
        @Published var minutes: Float = 20.0 {
            didSet {
                self.time = "\(Int(minutes)):00"
            }
        }
        
        private var initialTime = 0
        private var endDate = Date()
        
        func start(minutes: Float) {
            
            self.initialTime = Int(minutes)
            self.endDate = Date()
            self.isActive = true
            self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: endDate)!
        }
        
        func pause() {
            
            //add function to pause
            
        }
        
        func resset() {
            self.minutes = Float(initialTime)
            self.isActive = false
            self.time = "\(Int(minutes)):00"
        }
        
        func updateCountdown() {
            guard isActive else {return}
            let now = Date()
            let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            if(diff <= 0) {
                self.isActive = false
                self.time = "0:00"
                self.showingAlert = true //Where to add notifs
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

