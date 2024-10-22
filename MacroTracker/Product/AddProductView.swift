//
//  AddProductView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 25/09/2024.
//

import SwiftUI
import CodeScanner

struct AddProductView: View {
    @Binding var isPresented: Bool
    @Binding var meal: Meal
    @State private var showScanner = false
    @StateObject private var viewModel = AddProductViewModel(dataSource: .shared)

    var body: some View {
        NavigationStack {
            actionButtons
                .navigationTitle("Add a product")
                .toolbarTitleDisplayMode(.inline)

            mainContent
        }
        .onAppear {
            viewModel.load()
        }
        .searchable(text: $viewModel.searchText, prompt: "Search for a product")
        .sheet(isPresented: $viewModel.showQuickAdd) {
            QuickAddView(meal: $meal, isPresented: $viewModel.showQuickAdd)
        }
        .sheet(isPresented: $showScanner) {
            CodeScannerView(
                codeTypes: [.ean13],
                scanMode: .once,
                simulatedData: "3017620425035",
                shouldVibrateOnSuccess: true,
                videoCaptureDevice: .default(for: .video),
                completion: handleScan
            )
        }
        .sheet(isPresented: $viewModel.showDetails) {
            ProductDetailView(product: viewModel.product, meal: $meal) {
                isPresented = false
            }
        }
    }

    // MARK: - Subviews

    private var actionButtons: some View {
        HStack {
            addButton(image: "bolt.fill", label: "Quick add", action: {
                viewModel.showDetails = true
            })
            Spacer().frame(width: 50)
            addButton(image: "barcode.viewfinder", label: "Scan code", action: {
                showScanner = true
            })
        }
    }

    @ViewBuilder
    private var mainContent: some View {
        switch viewModel.state {
            case .loading:
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            case .normal:
                productList
            case let .failure(error):
                Text(error.localizedDescription)
            case let .success(product):
                EmptyView()
        }
    }

    private var productList: some View {
        List {
            if let user = viewModel.user, viewModel.searchText.isEmpty {
                ForEach(user.history) { product in
                    productButton(product: product, quantityText: "\(product.quantity)g") {
                        viewModel.product = product
                        viewModel.showDetails = true
                    }
                }
                .onDelete(perform: viewModel.deleteItem)
            } else {
                ForEach(viewModel.products) { product in
                    let productName = Locale.current.identifier.starts(with: "en") ? product.nameEN : product.nameFR
                    productButton(product: product, quantityText: "\(product.calories)kcal", productName: productName) {
                        viewModel.product = product
                        viewModel.showDetails = true
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.clear)
        .listStyle(PlainListStyle())
        .padding(.horizontal, 10)
    }

    // MARK: - Helper Methods

    private func addButton(image: String, label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack {
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(.bottom, 10)
                Text(label)
                    .font(.system(size: 16, weight: .bold))
                    .multilineTextAlignment(.center)
            }
            .padding()
            .frame(width: 120, height: 120)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.cardTint)
                    .opacity(0.7)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.shadowTint.opacity(0.3), lineWidth: 0.6)
                    )
            )
        }
        .buttonStyle(.plain)
    }

    private func productButton(product: ProductEntity, quantityText: String, productName: String? = nil, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(productName ?? product.nameFR)
                Spacer()
                Text(quantityText)
            }
            .font(.system(size: 16, weight: .bold))
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.cardTint)
                    .opacity(0.7)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.shadowTint.opacity(0.3), lineWidth: 0.6)
                    )
            )
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }

    // MARK: - Handle Scan Result

    private func handleScan(result: Result<ScanResult, ScanError>) {
        showScanner = false
        switch result {
            case let .success(result):
                let details = result.string.components(separatedBy: "\n")
                guard details.count == 1 else { return }
                viewModel.loadProduct(barcode: details[0])
            case let .failure(error):
                print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    MealView(meal: .constant(Meal(name: "Breakfast", date: Date(), products: [])))
}
