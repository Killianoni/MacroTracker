//
//  AddProductViewModel.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 25/09/2024.
//

import Foundation
import Combine

@MainActor
final class AddProductViewModel: ObservableObject {
    @Published var state: State = .normal
    @Published var product: Product? = nil
    @Published var showDetails = false

    enum State {
        case normal
        case loading
        case success(Product)
        case failure(Error)
    }

    private let getProductUseCase = GetProductUseCase()
    private var cancellables = Set<AnyCancellable>()

    func loadProduct(barcode: String) {
        getProductUseCase.execute(barcode: barcode)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.state = .loading
            })
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                    case .failure(let error):
                        self?.state = .failure(error)
                        print(error.localizedDescription)
                    case .finished:
                        break
                }
            }, receiveValue: { [weak self] response in
                self?.state = .success(response.product)
                self?.showDetails = true
            })
            .store(in: &cancellables)
    }
}
