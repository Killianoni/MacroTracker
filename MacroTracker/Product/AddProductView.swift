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
    @State private var showScanner = false
    @State private var showQuickAdd = false
    @Binding var meal: Meal
    @StateObject private var viewModel = AddProductViewModel(dataSource: .shared)
    var body: some View {
        NavigationStack {
            HStack {
                Button {
                    showQuickAdd = true
                } label: {
                    VStack {
                        Image(systemName: "bolt.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding(.bottom, 10)
                        Text("Quick add")
                            .font(.system(size: 16, weight: .bold))
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .frame(width: 120, height: 120)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.cardTint)
                        .opacity(0.7)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.shadowTint.opacity(0.3), lineWidth: 0.6)
                        )
                    )
                }
                .buttonStyle(.plain)

                Spacer()
                    .frame(width: 50)
                Button {
                    showScanner = true
                } label: {
                    VStack {
                        Image(systemName: "barcode.viewfinder")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.bottom, 10)
                        Text("Scan code")
                            .font(.system(size: 16, weight: .bold))
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .frame(width: 120, height: 120)
                    .background(RoundedRectangle(cornerRadius: 12)
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
            .navigationTitle("Add a product")
            .toolbarTitleDisplayMode(.inline)
            switch viewModel.state {
                case .loading:
                    Spacer()
                    ProgressView()
                    Spacer()
                case .normal:
                    if let user = viewModel.user, viewModel.searchText.isEmpty {
                        List {
                            ForEach(user.history) { product in
                                HStack {
                                    Text(product.nameFR)
                                    Spacer()
                                    Text(String(product.quantity) + "g")
                                }
                                .font(.system(size: 16, weight: .bold))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 12)
                                    .foregroundStyle(.cardTint)
                                    .opacity(0.7)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(.shadowTint.opacity(0.3), lineWidth: 0.6)
                                    )
                                )
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                        .listStyle(PlainListStyle())
                        .padding(.horizontal, 10)
                    } else {
                        List {
                            ForEach(viewModel.products) { product in
                                HStack {
                                    if product.nameFR == "Unknown" || product.nameFR.isEmpty {
                                        Text(product.nameEN)
                                    } else {
                                        Text(product.nameFR)
                                    }
                                    Spacer()
                                    Text(String(product.calories) + "kcal")
                                }
                                .font(.system(size: 16, weight: .bold))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 12)
                                    .foregroundStyle(.cardTint)
                                    .opacity(0.7)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(.shadowTint.opacity(0.3), lineWidth: 0.6)
                                    )
                                )
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                        .listStyle(PlainListStyle())
                        .padding(.horizontal, 10)
                    }
                case let .failure(error):
                    Text(error.localizedDescription)
                case let .success(product):
                    ProductDetailView(product: product, meal: $meal, didDissmiss: {
                        isPresented = false
                    })
                    Spacer()
            }
        }
        .onAppear {
            viewModel.load()
        }
        .searchable(text: $viewModel.searchText, prompt: "Search for a product")
        .sheet(isPresented: $showQuickAdd, onDismiss: {
            isPresented = false
        }, content: {
            QuickAddView(meal: $meal, isPresented: $showQuickAdd)
        })
        .sheet(isPresented: $showScanner) {
            CodeScannerView(codeTypes: [.ean13], scanMode: .once, simulatedData: "3017620425035", shouldVibrateOnSuccess: true, videoCaptureDevice: .default(for: .video), completion: handleScan)
        }

    }
}

extension AddProductView {
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
