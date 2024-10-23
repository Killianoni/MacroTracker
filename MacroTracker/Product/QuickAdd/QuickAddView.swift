//
//  QuickAddView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 03/10/2024.
//

import SwiftUI

struct QuickAddView: View {
    @Binding var meal: Meal
    @Binding var isPresented: Bool
    @StateObject var viewModel = QuickAddViewModel(dataSource: .shared)
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        FreeListRow(title: "Name",
                                    helper: "Product",
                                    unit: "",
                                    description: $viewModel.name)
                    }
                    Section {
                        FreeListRow(title: "Calories",
                                    description: $viewModel.calories)
                        
                        FreeListRow(title: "Proteins",
                                    description: $viewModel.proteins)
                        
                        FreeListRow(title: "Carbs",
                                    description: $viewModel.carbs)
                        
                        FreeListRow(title: "Sugar",
                                    description: $viewModel.sugars)
                        
                        FreeListRow(title: "Fat",
                                    description: $viewModel.fats)
                        
                        FreeListRow(title: "Saturated Fat",
                                    description: $viewModel.satFat)
                        
                        FreeListRow(title: "Fiber",
                                    description: $viewModel.fiber)
                        
                        FreeListRow(title: "Salt",
                                    description: $viewModel.salt)
                    }
                    Section {
                        HStack {
                            Text("Quantity")
                            Spacer()
                            TextField("100", text: $viewModel.quantity)
                                .multilineTextAlignment(.trailing)
                            Text("g")
                        }
                        Button {
                            let product = ProductEntity(nameFR: viewModel.name,
                                                        nameEN: viewModel.name,
                                                        quantity: Double(viewModel.quantity) ?? 100,
                                                        carbs: (Double(viewModel.carbs) ?? 0).dividedBy(Double(viewModel.quantity) ?? 100),
                                                        calories: (Double(viewModel.calories) ?? 0).dividedBy(Double(viewModel.quantity) ?? 100),
                                                        fat: (Double(viewModel.fats) ?? 0).dividedBy(Double(viewModel.quantity) ?? 100),
                                                        fiber: (Double(viewModel.fiber) ?? 0).dividedBy(Double(viewModel.quantity) ?? 100),
                                                        proteins: (Double(viewModel.proteins) ?? 0).dividedBy(Double(viewModel.quantity) ?? 100),
                                                        salt: (Double(viewModel.salt) ?? 0).dividedBy(Double(viewModel.quantity) ?? 100),
                                                        saturatedFat: (Double(viewModel.satFat) ?? 0).dividedBy(Double(viewModel.quantity) ?? 100),
                                                        sugars: (Double(viewModel.sugars) ?? 0).dividedBy(Double(viewModel.quantity) ?? 100)
                            )
                            meal.products.removeAll(where: { $0.id == product.id })
                            meal.products.append(product)
                            viewModel.user?.history.append(product)
                            viewModel.saveHistory()
                            isPresented = false
                        } label: {
                            HStack {
                                Spacer()
                                Text("Save product")
                                Spacer()
                            }
                        }
                    }
                }
            }
            .font(.system(size: 16, weight: .bold))
            .padding(.top, 60)
            .navigationTitle("Add new product")
            .navigationBarTitleDisplayMode(.large)
            .scrollContentBackground(.hidden)
            Spacer()
        }
        .onAppear {
            viewModel.load()
        }
    }
}

private struct FreeListRow: View {
    var title: String = ""
    var helper: String = "100"
    var unit: String = "g"
    @Binding var description: String
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            TextField(helper, text: $description)
                .multilineTextAlignment(.trailing)
            if !unit.isEmpty {
                Text(unit)
            }
        }
    }
}
