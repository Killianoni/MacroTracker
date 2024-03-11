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
    
    @Published var incrementCarbs: CGFloat = 0
    @Published var incrementProteins: CGFloat = 0
    @Published var incrementFat: CGFloat = 0
        
    @Published var totalCarbs = (UserDefaults.standard.string(forKey: "carbs")?.toCGFloat())!
    @Published var totalFat = (UserDefaults.standard.string(forKey: "fat")?.toCGFloat())!
    @Published var totalProteins = (UserDefaults.standard.string(forKey: "proteins")?.toCGFloat())!
    @Published var totalCalories = (UserDefaults.standard.string(forKey: "calories")?.toCGFloat())!
    
    @Published var currentDate: Date = .now

    var context: ModelContext?

    func isNewDay(macros: [Macros]) {
        guard macros.first(where: { Calendar.current.isDate($0.date, equalTo: currentDate, toGranularity: .day) }) != nil else {
            context?.insert(Macros(date: currentDate))
            return
        }
    }
    
    func getMacros(macros: [Macros]) -> Macros? {
        guard let macros = macros.first(where: { Calendar.current.isDate($0.date, equalTo: currentDate, toGranularity: .day) }) else {
            return nil
        }
        return macros
    }
    
    func add(macros: [Macros]) {
        if checkQuickEntrys(macros: getMacros(macros: macros)!) {
            getMacros(macros: macros)?.carbs += incrementCarbs
            getMacros(macros: macros)?.fat += incrementFat
            getMacros(macros: macros)?.proteins += incrementProteins
            
            let caloriesFromCarbs = incrementCarbs * 4
            let caloriesFromFat = incrementFat * 9
            let caloriesFromProteins = incrementProteins * 4
            
            getMacros(macros: macros)?.calories += caloriesFromCarbs + caloriesFromFat + caloriesFromProteins
            
            resetMacroIncrements()
        }
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
    
    func refreshDefaults() {
        totalCarbs = (UserDefaults.standard.string(forKey: "carbs")?.toCGFloat())!
        totalFat = (UserDefaults.standard.string(forKey: "fat")?.toCGFloat())!
        totalProteins = (UserDefaults.standard.string(forKey: "proteins")?.toCGFloat())!
        totalCalories = (UserDefaults.standard.string(forKey: "calories")?.toCGFloat())!

    }
}
