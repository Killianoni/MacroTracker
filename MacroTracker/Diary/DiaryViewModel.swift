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
    
    private enum Constants {
        static let checkRange = 0...999
    }

    enum State {
        case normal
        case loading
        case success(Product)
        case failure(Error)

        var isLoading: Bool {
            if case .loading = self { return true }
            return false
        }
    }

    @Published var incrementCarbs: Float = 0
    @Published var incrementProteins: Float = 0
    @Published var incrementFat: Float = 0
    @Published var currentDate: Date = .now

    @Published var macros = Macros()
    @Published var user = User()
    @Published var state: State = State.loading
    @Published var stepCount: Float = 0

    private var healthKitManager = HealthKitManager.shared
    private let dataSource: SwiftDataManager
    private let math = MathManager()
    private let getProductUseCase = GetProductUseCase()
    private var cancellables = Set<AnyCancellable>()

    init(dataSource: SwiftDataManager) {
        self.dataSource = dataSource
    }

    func load() {
        self.state = .loading
        fetchUser()
        fetchMacros()
        fetchSteps()
        self.state = .normal
    }

    private func fetchUser() {
        guard let user = dataSource.fetchUser() else {
            self.state = .normal
            return
        }
        self.user = user
    }

    private func fetchMacros() {
        guard let macros = dataSource.fetchMacros().first(where: { $0.date.isEqualTo(date: currentDate)}) else {
            dataSource.addMacros(Macros(date: currentDate))
            self.macros = dataSource.fetchMacros().first(where: { $0.date.isEqualTo(date: currentDate)})!
            self.state = .normal
            return
        }
        self.macros = macros
    }

    func fetchSteps() {
        healthKitManager.getSteps(date: currentDate) { [weak self] steps in
            DispatchQueue.main.async {
                self?.stepCount = steps
            }
        }
    }

    func add() {
        macros.carbs += incrementCarbs
        macros.fat += incrementFat
        macros.proteins += incrementProteins

        let caloriesFromCarbs = incrementCarbs * math.carbsMultiplier
        let caloriesFromFat = incrementFat * math.fatMultiplier
        let caloriesFromProteins = incrementProteins * math.proteinsMultiplier

        macros.calories += caloriesFromCarbs + caloriesFromFat + caloriesFromProteins

        resetMacroIncrements()
    }

    private func resetMacroIncrements() {
        incrementCarbs = 0
        incrementFat = 0
        incrementProteins = 0
    }

    func loadProduct(barcode: String) {
        getProductUseCase.execute(barcode: barcode)
            .handleEvents(receiveSubscription: { _ in
                self.state = .loading
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let error):
                        self.state = .failure(error)
                    case .finished:
                        break
                }
            }, receiveValue: { response in
                self.state = .success(response.product)
            })
            .store(in: &cancellables)
        self.state = .normal
    }
}
