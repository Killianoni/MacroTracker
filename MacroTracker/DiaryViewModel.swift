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
        static let quickAddMaxNumber: CGFloat = 999
        static let quickAddMinimalNumber: CGFloat = 0
    }
    
    @Published var incrementCarbs: CGFloat
    @Published var incrementProteins: CGFloat
    @Published var incrementFat: CGFloat
    @Published var dailyMacros: Macros?
    
    var context: ModelContext?
    
    var totalCarbs: CGFloat
    var totalFat: CGFloat
    var totalProteins: CGFloat
    var totalCalories: CGFloat
    
    @Published var currentDate: Date
    
    init(incrementCarbs: CGFloat = 0, incrementProteins: CGFloat = 0, incrementFat: CGFloat = 0, dailyMacros: Macros? = nil, context: ModelContext? = nil, currentDate: Date = .now) {
        self.incrementCarbs = incrementCarbs
        self.incrementProteins = incrementProteins
        self.incrementFat = incrementFat
        self.dailyMacros = dailyMacros
        self.context = context
        
        self.totalCarbs = (UserDefaults.standard.string(forKey: "carbs")?.toCGFloat())!
        self.totalFat = (UserDefaults.standard.string(forKey: "fat")?.toCGFloat())!
        self.totalProteins = (UserDefaults.standard.string(forKey: "proteins")?.toCGFloat())!
        self.totalCalories = (UserDefaults.standard.string(forKey: "calories")?.toCGFloat())!
        
        self.currentDate = currentDate
        
    }
    
    func add() {
        guard let macros = dailyMacros else {
            return
        }
        
        if checkQuickEntrys() {
            
            macros.carbs += incrementCarbs
            macros.fat += incrementFat
            macros.proteins += incrementProteins
            
            let caloriesFromCarbs = incrementCarbs * 4
            let caloriesFromFat = incrementFat * 9
            let caloriesFromProteins = incrementProteins * 4
            
            macros.calories += caloriesFromCarbs + caloriesFromFat + caloriesFromProteins
            
        }
        resetMacroIncrements()
    }

    private func resetMacroIncrements() {
        incrementCarbs = 0
        incrementFat = 0
        incrementProteins = 0
    }
    
    private func checkQuickEntrys() -> Bool {
        guard let macros = dailyMacros,
              macros.carbs + incrementCarbs >= Constants.quickAddMinimalNumber,
                  macros.fat + incrementFat >= Constants.quickAddMinimalNumber,
                  macros.proteins + incrementProteins >= Constants.quickAddMinimalNumber else {
                return false
            }
        
        guard let macros = dailyMacros,
                  macros.carbs < Constants.quickAddMaxNumber,
                  macros.fat < Constants.quickAddMaxNumber,
                  macros.proteins < Constants.quickAddMaxNumber else {
                return false
            }
        
        return true
    }
    
    private func insert(_ date: Date) {
        guard context != nil else {
            return
        }
        context!.insert(Macros(date: date))
    }
    
    func isNewDay() {
        if dailyMacros == nil {
            insert(.now)
        }
    }
    
    func fetchMacros(_ macros: [Macros], _ date: Date) {
        dailyMacros = macros.first(where: { Calendar.current.isDate($0.date, equalTo: date, toGranularity: .day) }) ?? nil
    }
}
