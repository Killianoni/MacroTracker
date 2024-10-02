//
//  Product.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 17/09/2024.
//

import Foundation

struct ProductResponse: Codable {
    let code: String
    let errors: [String]
    let product: Product
    let result: ResultStatus
    let status: String
    let warnings: [String]
}

struct Product: Codable, Hashable {
    let id : String?
    let productNameFR: String?
    let productNameEN: String?
    let quantity: Double?
    let carbs: Double?
    let calories: Double?
    let fat: Double?
    let fiber: Double?
    let proteins: Double?
    let salt: Double?
    let saturatedFat: Double?
    let sugars: Double?

    init(id: String? = UUID().uuidString, productNameFR: String?, productNameEN: String?, quantity: Double? = 100, carbs: Double?, calories: Double?, fat: Double?, fiber: Double?, proteins: Double?, salt: Double?, saturatedFat: Double?, sugars: Double?) {
        self.id = id
        self.productNameFR = productNameFR
        self.productNameEN = productNameEN
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

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case productNameFR = "product_name_fr"
        case productNameEN = "product_name_en"
        case quantity = "quantity"
        case carbs = "carbohydrates_100g"
        case calories = "energy-kcal_100g"
        case fat = "fat_100g"
        case fiber = "fiber_100g"
        case proteins = "proteins_100g"
        case salt = "salt_100g"
        case saturatedFat = "saturated-fat_100g"
        case sugars = "sugars_100g"
    }
}
struct ResultStatus: Codable {
    let id: String
    let lc_name: String
    let name: String
}
