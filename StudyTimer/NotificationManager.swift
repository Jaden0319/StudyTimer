//
//  NotificationManager.swift
//  StudyTimer
//
//  Created by Jaden Creech on 7/15/25.
//
import SwiftUI
import Foundation
import UserNotifications

class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuth(completion: @escaping (Bool) -> Void) {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error requesting notification permission: \(error)")
                    completion(false)
                } else {
                    print("Notification permission granted: \(granted)")
                    completion(granted)
                }
            }
        }
    }
    func scheduleNotification(title: String, subtitle: String, timeInterval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification scheduling error: \(error.localizedDescription)")
            }
        }
    }

    func clearPending() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("Pending notifications cleared")
    }
}

struct localNotif: View {
    
    var body: some View {
        VStack{
            Button("Press Me!") {
                NotificationManager.instance.requestAuth() { success in
                }
            }
        }
    }
}
#Preview {
    localNotif()
}
