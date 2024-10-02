//
//  ProductDetailViewModel.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 18/09/2024.
//

import Foundation
import Combine

@MainActor
final class ProductDetailViewModel: ObservableObject {
    enum State {
        case normal
        case loading
        case success(ProductEntity)
        case failure(Error)
    }
    @Published var state = State.loading
    private let getProductUseCase = GetProductUseCase(repository: MockProductRepository())
    private var cancellables = Set<AnyCancellable>()
}
