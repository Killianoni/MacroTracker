//
//  ProductVO.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 17/09/2024.
//

import Foundation

struct ProductResponse: Codable {
    let product: ProductVO
}

struct ProductSearchResponse: Codable {
    let products: [ProductVO]
}

struct ProductVO: Codable, Hashable {
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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        productNameFR = try container.decodeIfPresent(String.self, forKey: .productNameFR)
        productNameEN = try container.decodeIfPresent(String.self, forKey: .productNameEN)
        carbs = try ProductVO.decodeStringOrDouble(from: container, forKey: .carbs)
        calories = try ProductVO.decodeStringOrDouble(from: container, forKey: .calories)
        fat = try ProductVO.decodeStringOrDouble(from: container, forKey: .fat)
        fiber = try ProductVO.decodeStringOrDouble(from: container, forKey: .fiber)
        proteins = try ProductVO.decodeStringOrDouble(from: container, forKey: .proteins)
        salt = try ProductVO.decodeStringOrDouble(from: container, forKey: .salt)
        saturatedFat = try ProductVO.decodeStringOrDouble(from: container, forKey: .saturatedFat)
        sugars = try ProductVO.decodeStringOrDouble(from: container, forKey: .sugars)
    }

    static func decodeStringOrDouble(from container: KeyedDecodingContainer<CodingKeys>, forKey key: CodingKeys) throws -> Double? {
        if let doubleValue = try? container.decode(Double.self, forKey: key) {
            return doubleValue
        }
        if let stringValue = try? container.decode(String.self, forKey: key), let doubleValue = Double(stringValue) {
            return doubleValue
        }
        return nil
    }
}
