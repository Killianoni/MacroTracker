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
    @Attribute(.unique) var id: String = UUID().uuidString
    var date: Date
    var fat: CGFloat
    var carbs: CGFloat
    var proteins: CGFloat
    var calories: CGFloat
    
    init(id: String = UUID().uuidString, date: Date = .now, fat: CGFloat = 0, carbs: CGFloat = 0, proteins: CGFloat = 0, calories: CGFloat = 0) {
        self.id = id
        self.date = date
        self.fat = fat
        self.carbs = carbs
        self.proteins = proteins
        self.calories = calories
    }
}
