//
//  SearchProductUseCase.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 16/10/2024.
//

import Foundation
import Combine

final class SearchProductUseCase {
    private let repository: ProductRepository

    init(repository: ProductRepository = ProductRepository()) {
        self.repository = repository
    }

    func execute(productName: String) -> AnyPublisher<[ProductEntity], Error> {
        return repository.searchProduct(productName: productName)
    }
}

