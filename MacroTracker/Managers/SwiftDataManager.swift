//
//  SwiftDataManager.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 11/09/2024.
//

import Foundation
import SwiftData

final class SwiftDataManager {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = SwiftDataManager()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: Macros.self, User.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }

    // MARK: Macros -
    func fetchMacros() -> [Macros] {
        do {
            return try modelContext.fetch(FetchDescriptor<Macros>())
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    func addMacros(_ macros: Macros) {
        modelContext.insert(macros)
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: User -

    func fetchUser() -> User? {
        do {
            return try modelContext.fetch(FetchDescriptor<User>()).first!
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func addUser(_ user: User) {
        modelContext.insert(user)
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
