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
            Macros.self,
            User.self,
            Meal.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    var body: some Scene {
        WindowGroup {
            TabbarView(onboardingShowing: $showOnboarding)
                .fullScreenCover(isPresented: $showOnboarding) {
                    ObjectivesView()
                }
        }
        .modelContainer(sharedModelContainer)
    }
}
