//
//  Meal.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 24/09/2024.
//

import Foundation
import SwiftData

@Model
final class Meal {
    @Attribute(.unique) var id: String
    var name: String
    var date: Date
    var products: [Product]

    init(id: String = UUID().uuidString, name: String = "", date: Date = .now, products: [Product] = []) {
        self.id = id
        self.name = name
        self.date = date
        self.products = products
    }

    func getCalories() -> Double {
        products.reduce(0) { $0 + ($1.calories ?? 0) }
    }

    func getProtein() -> Double {
        products.reduce(0) { $0 + ($1.proteins ?? 0) }
    }

    func getCarbs() -> Double {
        products.reduce(0) { $0 + ($1.carbs ?? 0) }
    }

    func getFat() -> Double {
        products.reduce(0) { $0 + ($1.fat ?? 0) }
    }
}
