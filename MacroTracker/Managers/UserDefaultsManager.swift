//
//  UserDefaultsManager.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 20/12/2023.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    typealias defaults = UserDefaults
    
    func isFirstLaunch() -> Bool {
        if defaults.standard.object(forKey: "isFirstLaunch") == nil {
            return true
        }
        return false
    }
    
    func saveObjectives(_ fat: String, _ carbs: String, _ proteins: String, _ calories: String) {
        defaults.standard.set(fat, forKey: "fat")
        defaults.standard.set(carbs, forKey: "carbs")
        defaults.standard.set(proteins, forKey: "proteins")
        defaults.standard.set(calories, forKey: "calories")
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}
