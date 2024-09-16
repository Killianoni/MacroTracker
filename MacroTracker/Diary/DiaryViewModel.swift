//
//  DiaryViewModel.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 15/12/2023.
//

import Foundation
import SwiftData

class DiaryViewModel: ObservableObject {
    
    private enum Constants {
        static let checkRange = 0...999
    }

    enum State {
        case normal
        case loading
    }


    @Published var incrementCarbs: Float = 0
    @Published var incrementProteins: Float = 0
    @Published var incrementFat: Float = 0
    
    @Published var currentDate: Date = .now

    @Published var macros = Macros()
    @Published var user = User()

    @Published var state = State.loading

    private let dataSource: SwiftDataManager
    private let math = MathManager()

    init(dataSource: SwiftDataManager) {
        self.dataSource = dataSource
    }


//    func isNewDate(macros: [Macros]) {
//        if !macros.contains(where: { $0.date.isEqualTo(date: currentDate )}) {
//            context?.insert(Macros())
//        }
//    }

    func load() {
        fetchUser()
        fetchMacros()
        self.state = .normal
    }

    private func fetchUser() {
        self.state = .loading
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
    
    private func checkQuickEntrys(macros: Macros) -> Bool {
        guard Constants.checkRange.contains(Int(macros.carbs + incrementCarbs)),
              Constants.checkRange.contains(Int(macros.fat + incrementFat)),
              Constants.checkRange.contains(Int(macros.proteins + incrementProteins)) else {
                  return false
              }
        return true
    }
}
