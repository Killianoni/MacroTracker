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
    
    @Published var incrementCarbs: CGFloat = 0
    @Published var incrementProteins: CGFloat = 0
    @Published var incrementFat: CGFloat = 0
    
    @Published var currentDate: Date = .now
    
    var context: ModelContext?
        
    var totalCarbs = (UserDefaults.standard.string(forKey: "carbs")?.toCGFloat())!
    var totalFat = (UserDefaults.standard.string(forKey: "fat")?.toCGFloat())!
    var totalProteins = (UserDefaults.standard.string(forKey: "proteins")?.toCGFloat())!
    var totalCalories = (UserDefaults.standard.string(forKey: "calories")?.toCGFloat())!
    
    
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
            getMacros(macros: macros)?.carbs += incrementCarbs
            getMacros(macros: macros)?.fat += incrementFat
            getMacros(macros: macros)?.proteins += incrementProteins
            
            let caloriesFromCarbs = incrementCarbs * 4
            let caloriesFromFat = incrementFat * 9
            let caloriesFromProteins = incrementProteins * 4
            
            getMacros(macros: macros)?.calories += caloriesFromCarbs + caloriesFromFat + caloriesFromProteins
            
        resetMacroIncrements()
    }

    private func resetMacroIncrements() {
        incrementCarbs = 0
        incrementFat = 0
        incrementProteins = 0
    }
    
//    private func checkQuickEntrys() -> Bool {
//        guard let macros = dailyMacros,
//              macros.carbs + incrementCarbs >= Constants.quickAddMinimalNumber,
//                  macros.fat + incrementFat >= Constants.quickAddMinimalNumber,
//                  macros.proteins + incrementProteins >= Constants.quickAddMinimalNumber else {
//                return false
//            }
//        
//        guard let macros = dailyMacros,
//                  macros.carbs < Constants.quickAddMaxNumber,
//                  macros.fat < Constants.quickAddMaxNumber,
//                  macros.proteins < Constants.quickAddMaxNumber else {
//                return false
//            }
//        
//        return true
//    }
}
