//
//  User.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 13/09/2024.
//

import Foundation
import SwiftData

@Model
final class User {
    @Attribute(.unique) var id: String
    var proteins: Float
    var fat: Float
    var carbs: Float
    var calories: Float
    var isFirstLaunch: Bool

    init(id: String = UUID().uuidString, proteins: Float = 0, fat: Float = 0, carbs: Float = 0, calories: Float = 0, isFirstLaunch: Bool = true) {
        self.id = id
        self.proteins = proteins
        self.fat = fat
        self.carbs = carbs
        self.calories = calories
        self.isFirstLaunch = isFirstLaunch
    }
}

