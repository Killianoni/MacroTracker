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
    
    @Published var incrementCarbs: Float = 0
    @Published var incrementProteins: Float = 0
    @Published var incrementFat: Float = 0
        
    @Published var totalCarbs: Float = 0
    @Published var totalFat: Float = 0
    @Published var totalProteins: Float = 0
    @Published var totalCalories: Float = 0
    
    @Published var currentDate: Date = .now

    var context: ModelContext?

    func isNewDate(macros: [Macros]) {
        if !macros.contains(where: { $0.date.isEqualTo(date: currentDate )}) {
            context?.insert(Macros())
        }
    }

    func add(macros: Macros) {
        if checkQuickEntrys(macros: macros) {
            macros.carbs += incrementCarbs
            macros.fat += incrementFat
            macros.proteins += incrementProteins

            let caloriesFromCarbs = incrementCarbs * 4
            let caloriesFromFat = incrementFat * 9
            let caloriesFromProteins = incrementProteins * 4
            
            macros.calories += caloriesFromCarbs + caloriesFromFat + caloriesFromProteins
            
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
    
//    func refreshDefaults() {
//        totalCarbs = (UserDefaults.standard.string(forKey: "carbs")?.toFloat())!
//        totalFat = (UserDefaults.standard.string(forKey: "fat")?.toFloat())!
//        totalProteins = (UserDefaults.standard.string(forKey: "proteins")?.toFloat())!
//        totalCalories = (UserDefaults.standard.string(forKey: "calories")?.toFloat())!
//    }
}
