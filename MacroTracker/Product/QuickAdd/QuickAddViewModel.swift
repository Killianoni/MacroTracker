//
//  QuickAddViewModel.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 03/10/2024.
//

import Foundation

@MainActor
final class QuickAddViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var calories: String = ""
    @Published var proteins: String = ""
    @Published var carbs: String = ""
    @Published var sugars: String = ""
    @Published var fats: String = ""
    @Published var satFat: String = ""
    @Published var fiber: String = ""
    @Published var salt: String = ""
    @Published var quantity: String = ""
}
