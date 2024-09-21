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
        case success(Product)
        case failure(Error)
    }
    @Published var state = State.loading
    private let getProductUseCase = GetProductUseCase()
    private var cancellables = Set<AnyCancellable>()


    func loadProduct(barcode: String) {
        getProductUseCase.execute(barcode: barcode)
            .handleEvents(receiveSubscription: { _ in
                self.state = .loading
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let error):
                        self.state = .failure(error)
                    case .finished:
                        break
                }
            }, receiveValue: { response in
                self.state = .success(response.product)
            })
            .store(in: &cancellables)
        self.state = .normal
    }
}
