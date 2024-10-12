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
    enum State {
        case normal
        case loading
        case success(ProductEntity)
        case failure(Error)
    }

    @Published var state: State = .normal
    @Published var product: ProductEntity? = nil
    @Published var showDetails = false
    @Published var user: User?

    private let getProductUseCase = GetProductUseCase(repository: ProductRepository())
    private var cancellables = Set<AnyCancellable>()
    private let dataSource: SwiftDataManager

    init(dataSource: SwiftDataManager) {
        self.dataSource = dataSource
    }

    func load() {
        fetchUser()
    }

    private func fetchUser() {
        self.state = .loading
        guard let user = dataSource.fetchUser() else {
            self.state = .normal
            return
        }
        self.user = user
        self.state = .normal
    }

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
                self?.state = .success(response)
                self?.showDetails = true
            })
            .store(in: &cancellables)
    }
}
