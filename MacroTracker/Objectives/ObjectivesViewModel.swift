//
//  ObjectivesViewModel.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 15/12/2023.
//

import Foundation

// TODO: Check les entrées des champs
class ObjectivesViewModel: ObservableObject {
    @Published var height: String = "180"
    @Published var weight: String = "80"
    @Published var age: String = "20"
    private let proteinCoefficient = 4
    private let fatCoefficient = 9
    private let carbCoefficient = 4

    private let dataSource: SwiftDataManager

    init(dataSource: SwiftDataManager) {
        self.dataSource = dataSource
    }

    func save() {
//        dataSource.editUser(<#T##newUser: User##User#>)
    }
}
