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
        if UserDefaults().object(forKey: "isFirstLaunch") == nil {
            defaults.setValue(false, forKey: "isFirstLaunch")
            return true
        }
        UserDefaults.standard.setValue(true, forKey: "isFirstLaunch")
        return false
    }
    
    func saveObjectives(_ fat: String, _ carbs: String, _ proteins: String, _ calories: String) {
        UserDefaults.standard.set(fat, forKey: "fat")
        UserDefaults.standard.set(carbs, forKey: "carbs")
        UserDefaults.standard.set(proteins, forKey: "proteins")
        UserDefaults.standard.set(calories, forKey: "calories")
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}
