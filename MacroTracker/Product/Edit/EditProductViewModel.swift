//
//  EditProductViewModel.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 26/09/2024.
//

import Foundation

final class EditProductViewModel: ObservableObject {
    let dataSource: SwiftDataManager

    init(dataSource: SwiftDataManager) {
        self.dataSource = dataSource
    }
}
