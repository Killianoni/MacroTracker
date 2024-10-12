//
//  QuickAddViewModel.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 03/10/2024.
//

import Foundation

@MainActor
final class QuickAddViewModel: ObservableObject {
    enum State {
        case normal
        case loading
        case success
        case failure
    }

    @Published var state: State = .normal
    @Published var name: String = ""
    @Published var calories: String = ""
    @Published var proteins: String = ""
    @Published var carbs: String = ""
    @Published var sugars: String = ""
    @Published var fats: String = ""
    @Published var satFat: String = ""
    @Published var fiber: String = ""
    @Published var salt: String = ""
    @Published var quantity: String = ""
    @Published var user: User?

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
