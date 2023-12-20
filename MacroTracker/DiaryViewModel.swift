//
//  DiaryViewModel.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 15/12/2023.
//

import Foundation
import SwiftData

class DiaryViewModel: ObservableObject {
    
    @Published var incrementCarbs: CGFloat
    @Published var incrementProteins: CGFloat
    @Published var incrementFat: CGFloat
    @Published var dailyMacros: Macros?
    
    var context: ModelContext?
    
    var totalCarbs: CGFloat
    var totalFat: CGFloat
    var totalProteins: CGFloat
    var totalCalories: CGFloat
    
    init(incrementCarbs: CGFloat = 0, incrementProteins: CGFloat = 0, incrementFat: CGFloat = 0, dailyMacros: Macros? = nil, context: ModelContext? = nil) {
        self.incrementCarbs = incrementCarbs
        self.incrementProteins = incrementProteins
        self.incrementFat = incrementFat
        self.dailyMacros = dailyMacros
        self.context = context
        
        self.totalCarbs = (UserDefaults.standard.string(forKey: "carbs")?.toCGFloat())!
        self.totalFat = (UserDefaults.standard.string(forKey: "fat")?.toCGFloat())!
        self.totalProteins = (UserDefaults.standard.string(forKey: "proteins")?.toCGFloat())!
        self.totalCalories = (UserDefaults.standard.string(forKey: "calories")?.toCGFloat())!
    }
    
    func add() {
        guard let macros = dailyMacros else {
            return
        }

        macros.carbs += incrementCarbs
        macros.fat += incrementFat
        macros.proteins += incrementProteins

        let caloriesFromCarbs = incrementCarbs * 4
        let caloriesFromFat = incrementFat * 9
        let caloriesFromProteins = incrementProteins * 4

        macros.calories += caloriesFromCarbs + caloriesFromFat + caloriesFromProteins

        resetMacroIncrements()
    }

    private func resetMacroIncrements() {
        incrementCarbs = 0
        incrementFat = 0
        incrementProteins = 0
    }
    
    func insert() {
        guard context != nil else {
            return
        }
        context!.insert(Macros(date: Date.now, fat: 0, carbs: 0, proteins: 0))
    }
}
