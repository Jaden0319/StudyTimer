//
//  StudyTimerApp.swift
//  StudyTimer
//
//  Created by Jaden Creech on 2/3/25.
//

import SwiftUI
import SwiftData

@main
struct StudyTimerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            BaseView()
        }
        .modelContainer(sharedModelContainer)
    }
}
