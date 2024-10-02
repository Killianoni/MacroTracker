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
    @State private var searchText = ""
    @State private var showScanner = false
    @Binding var meal: Meal
    @StateObject private var viewModel = AddProductViewModel()
    var body: some View {
        switch viewModel.state {
            case .loading:
                ProgressView()
            case .normal:
                NavigationStack {
                    HStack {
                        Button {
                            // Ajout rapide
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
                    Spacer()
                }
                .searchable(text: $searchText, prompt: "Search for a product")
                .sheet(isPresented: $showScanner) {
                    // on dismiss
                } content: {
                    CodeScannerView(codeTypes: [.ean13], scanMode: .once, simulatedData: "3017620425035", shouldVibrateOnSuccess: true, videoCaptureDevice: .default(for: .video), completion: handleScan)
                }
            case let .failure(error):
                Text(error.localizedDescription)
            case let .success(product):
                ProductDetailView(product: product, meal: $meal, didDissmiss: {
                    isPresented = false
                })
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
