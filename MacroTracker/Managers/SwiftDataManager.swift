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
        self.modelContainer = try! ModelContainer(for: Macros.self, User.self, Meal.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }

    func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteAllObjects() {
        do {
            try modelContext.delete(model: User.self)
            try modelContext.delete(model: Macros.self)
            try modelContext.delete(model: Meal.self)
        } catch {
            print("Failed to clear all SwiftData objects.")
        }
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
            return try modelContext.fetch(FetchDescriptor<User>()).first
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func addUser(_ user: User) {
        do {
            modelContext.insert(user)
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func saveHistory(_ newUser: User) {
        do {
            if let user = try modelContext.fetch(FetchDescriptor<User>()).first {
                user.history = newUser.history
            }
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: Meal -

    func fetchMeals() -> [Meal]? {
        do {
            return try modelContext.fetch(FetchDescriptor<Meal>())
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    func addMeal(_ meal: Meal) {
        modelContext.insert(meal)
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
