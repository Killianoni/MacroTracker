//
//  OpenFoodFactsRepository.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 17/09/2024.
//

import Foundation
import Combine

// product_name_fr,product_name_en,energy-kcal_100g,fat_100g,saturated-fat_100g,carbohydrates_100g,sugars_100g,proteins_100g,fiber_100g,salt_100g

final class ProductRepository {
    private let api = OpenFoodFactsAPI()

    func getProduct(barcode: String) -> AnyPublisher<ProductResponse, Error> {
        return api.fetchProduct(barcode: barcode, cc: Locale.current.identifier.description, lc: Locale.current.identifier.description, fields: [
            "product_name_fr", "product_name_en", "carbohydrates_100g", "energy-kcal_100g", "fat_100g", "fiber_100g", "proteins_100g", "salt_100g", "saturated-fat_100g", "sugars_100g"
        ])
    }
}
