//
//  SettingsModel.swift
//  StudyTimer
//
//  Created by Jaden Creech on 2/10/25.
//

import Foundation

struct Settings: Codable, Equatable {
    static let modes: [Int: String] = [
        0: "StudyTime",
        1: "Short Break",
        2: "Long Break"
    ]
    
    static let fonts: [String: String] = [
        "Default": "Avenir-Medium",
        "Fancy": "Snell Roundhand",
        "Cartoon": "Chalkboard SE",
        "Robot": "Menlo"
    ]
    
    static let sounds: [String: String] = [
        "Default": "default_alarm",
        "Rainbow": "rainbow_alarm",
        "Digital": "digital_alarm",
        "Orchestra": "orchestral_alarm"
    ]
    
    static let notificationModes: [Int: String] = [
        0:"Last",
        1:"Every"
    ]
    
    static let allColors: [Int] = [
        0xE84D4D, 0x2EAACE, 0x11669C,
        0xF4D35E, 0xB388EB, 0xFFA07A,
        0x8BC34A, 0x0FFB34
    ]
    
    static let avatars: [Int: String] = [
        0: "man1",
        1: "man2",
        2: "man3",
        3: "man4",
        4: "man5",
        5: "woman1",
        6: "woman2",
        7: "woman3",
        8: "woman4",
        9: "woman5"
    ]
    // MARK: - User settings
    var alarmSound: String = "Default"
    var tickingOn: Bool = false
    var timerFont: String = "Default"
    var modeTimes: [Float] = [25.0, 5.0, 10.0]
    var backgroundColor: Int = 0xE84D4D
    var modeColors: [Int] = [0xE84D4D, 0x2EAACE, 0x11669C]
    var currentMode: Int = 0
    var longBreakIntv: Int = 2
    var breakCount: Int = 0
    var autoStartBreaks: Bool = false
    var autoStartStudy: Bool = false
    var notificationsOn: Bool = false
    var notificationMode: Int = 0 //0: Last, 1: Every
    var notificationTime: Int = 5
    
    static let `default` = Settings()
    
    static func == (lhs: Settings, rhs: Settings) -> Bool {
        return lhs.alarmSound == rhs.alarmSound &&
        lhs.tickingOn        == rhs.tickingOn &&
        lhs.timerFont        == rhs.timerFont &&
        lhs.modeTimes        == rhs.modeTimes &&
        lhs.backgroundColor  == rhs.backgroundColor &&
        lhs.modeColors       == rhs.modeColors &&
        lhs.longBreakIntv    == rhs.longBreakIntv &&
        lhs.autoStartBreaks  == rhs.autoStartBreaks &&
        lhs.autoStartStudy   == rhs.autoStartStudy  &&
        lhs.notificationsOn  == rhs.notificationsOn &&
        lhs.notificationMode == rhs.notificationMode &&
        lhs.notificationTime == rhs.notificationTime
    }
}
