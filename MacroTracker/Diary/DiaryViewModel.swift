//
//  DiaryViewModel.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 15/12/2023.
//

import Foundation
import SwiftData
import Combine

@MainActor
final class DiaryViewModel: ObservableObject {

    enum State {
        case normal
        case loading
        case success(ProductEntity)
        case failure(Error)

        var isLoading: Bool {
            if case .loading = self { return true }
            return false
        }
    }

    @Published var currentDate: Date = .now
    @Published var user: User?
    @Published var meals = [Meal]()
    @Published var state: State = State.loading
    @Published var stepCount: Float = 0

    private var healthKitManager = HealthKitManager.shared
    private let dataSource: SwiftDataManager
    private let math = MathManager()

    init(dataSource: SwiftDataManager) {
        self.dataSource = dataSource
    }

    func load() {
        fetchUser()
        fetchSteps()
        fetchMeals()
    }

    private func fetchUser() {
        self.state = .loading
        guard let user = dataSource.fetchUser() else {
            self.state = .normal
            return
        }
        self.user = user
        self.state = .normal
    }

    private func fetchMeals() {
        self.state = .loading
        guard let meals = dataSource.fetchMeals()?.filter({ $0.date.isEqualTo(date: currentDate) }), meals != [] else {
            addMeal(meal: Meal(name: "Breakfast", date: currentDate))
            addMeal(meal: Meal(name: "Launch", date: currentDate))
            addMeal(meal: Meal(name: "Snack", date: currentDate))
            addMeal(meal: Meal(name: "Diner", date: currentDate))
            self.meals = dataSource.fetchMeals()?.filter({ $0.date.isEqualTo(date: currentDate) }) ?? []
            self.state = .normal
            return
        }
        self.meals = meals
        self.state = .normal
    }

    private func fetchSteps() {
        self.state = .loading
        healthKitManager.getSteps(date: currentDate) { [weak self] steps in
            DispatchQueue.main.async {
                self?.stepCount = steps
            }
        }
        self.state = .normal
    }

    private func addMeal(meal: Meal) {
        dataSource.addMeal(meal)
    }

    func getAllProteins() -> Float {
        Float(meals.reduce(0) { $0 + $1.getProtein() })
    }

    func getAllCarbs() -> Float {
        Float(meals.reduce(0) { $0 + $1.getCarbs() })
    }

    func getAllFat() -> Float {
        Float(meals.reduce(0) { $0 + $1.getFat() })
    }

    func getAllCalories() -> Float {
        Float(meals.reduce(0) { $0 + $1.getCalories() })
    }
}
