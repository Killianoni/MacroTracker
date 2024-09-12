//
//  ObjectivesViewModel.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 15/12/2023.
//

import Foundation

class ObjectivesViewModel: ObservableObject {
    @Published var proteinsText = ""
    @Published var fatText = ""
    @Published var carbsText = ""
    @Published var caloriesText = ""
    @Published var errorMessage = ""
    
    private let proteinCoefficient = 4
    private let fatCoefficient = 9
    private let carbCoefficient = 4
    
    func save() {
        if validateText(proteinsText), validateText(fatText), validateText(carbsText) {
            let proteins = Int(proteinsText)!
            let fat = Int(fatText)!
            let carbs = Int(carbsText)!
            
            if caloriesText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                caloriesText = String(proteins * proteinCoefficient + fat * fatCoefficient + carbs * carbCoefficient)
            }
            
            UserDefaultsManager.shared.saveObjectives(fatText, carbsText, proteinsText, caloriesText)
            UserDefaults.standard.setValue(true, forKey: "isFirstLaunch")
        }
    }
    
    private func validateText(_ text: String) -> Bool {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, (Int(text) != nil) else {
            return false
        }
        return true
    }
}
