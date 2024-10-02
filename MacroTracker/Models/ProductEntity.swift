//
//  ProductEntity.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 02/10/2024.
//

import SwiftData
import Foundation

@Model
class ProductEntity: Identifiable {
    let id: String
    let nameFR: String
    let nameEN: String
    let quantity: Double
    let carbs: Double
    let calories: Double
    let fat: Double
    let fiber: Double
    let proteins: Double
    let salt: Double
    let saturatedFat: Double
    let sugars: Double

    init(
        id: String = UUID().uuidString,
        nameFR: String,
        nameEN: String,
        quantity: Double = 100,
        carbs: Double,
        calories: Double,
        fat: Double,
        fiber: Double,
        proteins: Double,
        salt: Double,
        saturatedFat: Double,
        sugars: Double
    ) {
        self.id = id
        self.nameFR = nameFR
        self.nameEN = nameEN
        self.quantity = quantity
        self.carbs = carbs
        self.calories = calories
        self.fat = fat
        self.fiber = fiber
        self.proteins = proteins
        self.salt = salt
        self.saturatedFat = saturatedFat
        self.sugars = sugars
    }
}
