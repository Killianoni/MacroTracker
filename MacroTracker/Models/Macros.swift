//
//  Macros.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 14/12/2023.
//

import Foundation
import SwiftData

@Model
final class Macros {
    @Attribute(.unique) var id: String
    var date: Date
    var fat: Float
    var carbs: Float
    var proteins: Float
    var calories: Float

    init(id: String = UUID().uuidString, date: Date = .now, fat: Float = 0, carbs: Float = 0, proteins: Float = 0, calories: Float = 0) {
        self.id = id
        self.date = date
        self.fat = fat
        self.carbs = carbs
        self.proteins = proteins
        self.calories = calories
    }
}
