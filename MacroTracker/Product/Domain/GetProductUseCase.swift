//
//  GetProductUseCase.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 17/09/2024.
//

import Foundation
import Combine

final class GetProductUseCase {
    private let repository: ProductRepository

    init(repository: ProductRepository = ProductRepository()) {
        self.repository = repository
    }

    func execute(barcode: String) -> AnyPublisher<ProductEntity, Error> {
        return repository.getProduct(barcode: barcode)
    }
}
