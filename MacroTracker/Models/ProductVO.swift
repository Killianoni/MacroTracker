//
//  ProductVO.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 17/09/2024.
//

import Foundation

struct ProductVO: Codable {
    let productNameFR: String?
    let productNameEN: String?
    let carbs: Double?
    let calories: Double?
    let fat: Double?
    let fiber: Double?
    let proteins: Double?
    let salt: Double?
    let saturatedFat: Double?
    let sugars: Double?

    init(productNameFR: String?, productNameEN: String?, carbs: Double?, calories: Double?, fat: Double?, fiber: Double?, proteins: Double?, salt: Double?, saturatedFat: Double?, sugars: Double?) {
        self.productNameFR = productNameFR
        self.productNameEN = productNameEN
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
