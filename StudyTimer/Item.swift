//
//  Item.swift
//  StudyTimer
//
//  Created by Jaden Creech on 2/3/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
