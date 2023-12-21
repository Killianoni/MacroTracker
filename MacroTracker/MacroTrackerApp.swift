//
//  MacroTrackerApp.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 14/12/2023.
//

import SwiftUI
import SwiftData

@main
struct MacroTrackerApp: App {
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool?
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Macros.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        UserDefaultsManager.shared.isFirstLaunch()
    }
    
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch! {
                ObjectivesView()
            } else {
                DiaryView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
