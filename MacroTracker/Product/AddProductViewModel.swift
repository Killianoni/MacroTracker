//
//  AddProductViewModel.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 25/09/2024.
//

import SwiftUI
import Combine

@MainActor
final class AddProductViewModel: ObservableObject {
    enum State {
        case normal
        case loading
        case success(ProductEntity)
        case failure(Error)
        
        var isLoading: Bool {
            switch self {
                case .loading:
                    return true
                default :
                    return false
            }
        }
    }

    @Published var state: State = .normal
    @Published var product: ProductEntity? = nil
    @Published var showDetails = false
    @Published var showQuickAdd = false
    @Published var user: User?
    @Published var products: [ProductEntity] = []
    @Published var searchText = ""

    private let getProductUseCase = GetProductUseCase(repository: ProductRepository())
    private let searchProductUseCase = SearchProductUseCase(repository: ProductRepository())
    private var cancellables = Set<AnyCancellable>()
    private let dataSource: SwiftDataManager

    init(dataSource: SwiftDataManager) {
        self.dataSource = dataSource
        setupSearchDebounce()
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
                self?.state = .normal
                self?.product = response
                self?.showDetails = true
            })
            .store(in: &cancellables)
    }

    func deleteItem(at offsets: IndexSet) {
        user?.history.remove(atOffsets: offsets)
    }

    private func searchProduct(productName: String) {
        searchProductUseCase.execute(productName: productName)
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
                self?.state = .normal
                self?.products = response
            })
            .store(in: &cancellables)
    }

    private func setupSearchDebounce() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] newValue in
                guard !newValue.isEmpty else {
                    self?.products = []
                    return
                }
                self?.searchProduct(productName: newValue)
            }
            .store(in: &cancellables)
    }
}
