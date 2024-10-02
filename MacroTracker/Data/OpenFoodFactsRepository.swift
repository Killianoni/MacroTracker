//
//  OpenFoodFactsRepository.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 17/09/2024.
//

import Foundation
import Combine

// product_name_fr,product_name_en,energy-kcal_100g,fat_100g,saturated-fat_100g,carbohydrates_100g,sugars_100g,proteins_100g,fiber_100g,salt_100g

class ProductRepository {
    private let api = OpenFoodFactsAPI()

    func getProduct(barcode: String) -> AnyPublisher<ProductEntity, Error> {
        return api.fetchProduct(barcode: barcode, cc: Locale.current.identifier.description, lc: Locale.current.identifier.description, fields: [
            "product_name_fr", "product_name_en", "carbohydrates_100g", "energy-kcal_100g", "fat_100g", "fiber_100g", "proteins_100g", "salt_100g", "saturated-fat_100g", "sugars_100g"
        ])
        .tryMap { (productVO: ProductVO) -> ProductEntity in
            return self.mapToEntity(productVO)
        }
        .eraseToAnyPublisher()
    }

    private func mapToEntity(_ vo: ProductVO) -> ProductEntity {
        return ProductEntity(
            nameFR: vo.productNameFR ?? "Unknown",
            nameEN: vo.productNameEN ?? "Unknown",
            carbs: vo.carbs ?? 0.0,
            calories: vo.calories ?? 0.0,
            fat: vo.fat ?? 0.0,
            fiber: vo.fiber ?? 0.0,
            proteins: vo.proteins ?? 0.0,
            salt: vo.salt ?? 0.0,
            saturatedFat: vo.saturatedFat ?? 0.0,
            sugars: vo.sugars ?? 0.0
        )
    }
}

final class MockProductRepository: ProductRepository {
    private let mockProductVO: ProductVO = ProductVO(
        productNameFR: "Produit Test",
        productNameEN: "Test Product",
        carbs: 10.0,
        calories: 100.0,
        fat: 5.0,
        fiber: 2.0,
        proteins: 4.0,
        salt: 1.0,
        saturatedFat: 1.5,
        sugars: 8.0
    )
    
    override func getProduct(barcode: String) -> AnyPublisher<ProductEntity, Error> {
        // Simulate a successful fetch with a delay
        return Just(mockProductVO)
            .setFailureType(to: Error.self) // Set the failure type
            .delay(for: .seconds(1), scheduler: RunLoop.main) // Simulate network delay
            .tryMap { productVO in
                return self.mapToEntity(productVO)
            }
            .eraseToAnyPublisher()
    }

    private func mapToEntity(_ vo: ProductVO) -> ProductEntity {
        return ProductEntity(
            nameFR: vo.productNameFR ?? "Unknown",
            nameEN: vo.productNameEN ?? "Unknown",
            carbs: vo.carbs ?? 0.0,
            calories: vo.calories ?? 0.0,
            fat: vo.fat ?? 0.0,
            fiber: vo.fiber ?? 0.0,
            proteins: vo.proteins ?? 0.0,
            salt: vo.salt ?? 0.0,
            saturatedFat: vo.saturatedFat ?? 0.0,
            sugars: vo.sugars ?? 0.0
        )
    }
}
