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

    func editUser() {
        self.state = .loading
        guard let user = user else {
            self.state = .normal
            return
        }
        dataSource.editUser(user)
        load()
    }
}
