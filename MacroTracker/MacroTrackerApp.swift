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
    @AppStorage("shouldShowOnboarding") var showOnboarding: Bool = true
    @MainActor var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Macros.self, User.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
//            SwiftDataManager.shared.deleteAllObjects()
            if try container.mainContext.fetch(FetchDescriptor<User>()).isEmpty {
                container.mainContext.insert(User())
            }
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    var body: some Scene {
        WindowGroup {
            if showOnboarding == true {
                ObjectivesView()
                    .animation(.easeIn, value: showOnboarding)
            } else {
                TabbarView()
                    .animation(.easeIn, value: showOnboarding)
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
