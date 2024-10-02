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
    var products: [ProductEntity]

    init(id: String = UUID().uuidString, name: String = "", date: Date = .now, products: [ProductEntity] = []) {
        self.id = id
        self.name = name
        self.date = date
        self.products = products
    }

    func getCalories() -> Double {
        products.reduce(0) { $0 + ($1.calories) }
    }

    func getProtein() -> Double {
        products.reduce(0) { $0 + ($1.proteins) }
    }

    func getCarbs() -> Double {
        products.reduce(0) { $0 + ($1.carbs) }
    }

    func getFat() -> Double {
        products.reduce(0) { $0 + ($1.fat) }
    }
}
