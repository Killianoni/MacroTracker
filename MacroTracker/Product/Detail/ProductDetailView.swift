//
//  ProductDetailView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 18/09/2024.
//

import SwiftUI

struct ProductDetailView: View {
    @State var product: Product?
    @Binding var meal: Meal
    @StateObject var viewModel = ProductDetailViewModel()
    @State var quantity: String = ""
    var didDissmiss: (() -> Void)
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        listRow(title: "Calories", description: String(product?.calories?.dividedBy(Double(quantity) ?? 100) ?? 0))
                        listRow(title: "Proteins", description: String(product?.proteins?.dividedBy(Double(quantity) ?? 100) ?? 0))
                        listRow(title: "Carbs", description: String(product?.carbs?.dividedBy(Double(quantity) ?? 100) ?? 0))
                        listRow(title: "Sugar", description: String(product?.sugars?.dividedBy(Double(quantity) ?? 100) ?? 0))
                        listRow(title: "Fat", description: String(product?.fat?.dividedBy(Double(quantity) ?? 100) ?? 0))
                        listRow(title: "Saturated Fat", description: String(product?.saturatedFat?.dividedBy(Double(quantity) ?? 100) ?? 0))
                        listRow(title: "Fiber", description: String(product?.fiber?.dividedBy(Double(quantity) ?? 100) ?? 0))
                        listRow(title: "Salt", description: String(product?.salt?.dividedBy(Double(quantity) ?? 100) ?? 0))
                        HStack {
                            Text("My quantity")
                            Spacer()
                            TextField("100", text: $quantity)
                                .multilineTextAlignment(.trailing)
                            Text("g")
                        }
                    }
                    Button {
                        if let product = product {
                            meal.products.append(Product(productNameFR: product.productNameFR,
                                                         productNameEN: product.productNameEN,
                                                         quantity: Double(quantity) ?? 100,
                                                         carbs: product.carbs?.dividedBy(Double(quantity) ?? 100),
                                                         calories: product.calories?.dividedBy(Double(quantity) ?? 100),
                                                         fat: product.fat?.dividedBy(Double(quantity) ?? 100) ?? 0,
                                                         fiber: product.fiber?.dividedBy(Double(quantity) ?? 100) ?? 0,
                                                         proteins: product.proteins?.dividedBy(Double(quantity) ?? 100) ?? 0,
                                                         salt: product.salt?.dividedBy(Double(quantity) ?? 100) ?? 0,
                                                         saturatedFat: product.saturatedFat?.dividedBy(Double(quantity) ?? 100) ?? 0,
                                                         sugars: product.sugars?.dividedBy(Double(quantity) ?? 100) ?? 0
                                                        )
                            )
                        } else {
                            print("no product")
                        }
                        didDissmiss()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Add product")
                            Spacer()
                        }
                    }
                }
                .font(.system(size: 16, weight: .bold))
                .padding(.top, 60)
                
                .navigationTitle(product?.productNameFR ?? "Product")
                .navigationBarTitleDisplayMode(.large)
                Spacer()
            }
        }
    }
}

struct listRow: View {
    var title: String = ""
    var description: String = ""
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(description)
        }
    }
}

#Preview {
    ProductDetailView(meal: .constant(Meal()), didDissmiss: {} )
}
