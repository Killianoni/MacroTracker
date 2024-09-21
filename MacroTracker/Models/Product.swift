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

struct Product: Codable {
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

    enum CodingKeys: String, CodingKey {
        case productNameFR = "product_name_fr"
        case productNameEN = "product_name_en"
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
