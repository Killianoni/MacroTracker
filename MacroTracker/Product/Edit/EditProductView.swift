//
//  EditProductView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 26/09/2024.
//

import SwiftUI

struct EditProductView: View {
    @Binding var product: Product?
    @Binding var meal: Meal
    @Binding var isPresented: Bool
//    @StateObject var viewModel = ProductDetailViewModel()
    @State var newQuantity: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        if let quantity = product?.quantity {
                            listRow(title: "Calories",
                                    description: String((product?.calories?
                                        .reseted(quantity) ?? 0)
                                        .dividedBy((Double(newQuantity) == nil
                                                    ? quantity
                                                    : Double(newQuantity)) ?? 0)))

                            listRow(title: "Proteins",
                                    description: String((product?.proteins?
                                        .reseted(quantity) ?? 0)
                                        .dividedBy((Double(newQuantity) == nil
                                                    ? quantity
                                                    : Double(newQuantity)) ?? 0)))

                            listRow(title: "Carbs",
                                    description: String((product?.carbs?
                                        .reseted(quantity) ?? 0)
                                        .dividedBy((Double(newQuantity) == nil
                                                    ? quantity
                                                    : Double(newQuantity)) ?? 0)))

                            listRow(title: "Sugar",
                                    description: String((product?.sugars?
                                        .reseted(quantity) ?? 0)
                                        .dividedBy((Double(newQuantity) == nil
                                                    ? quantity
                                                    : Double(newQuantity)) ?? 0)))

                            listRow(title: "Fat",
                                    description: String((product?.fat?
                                        .reseted(quantity) ?? 0)
                                        .dividedBy((Double(newQuantity) == nil
                                                    ? quantity
                                                    : Double(newQuantity)) ?? 0)))

                            listRow(title: "Saturated Fat",
                                    description: String((product?.saturatedFat?
                                        .reseted(quantity) ?? 0)
                                        .dividedBy((Double(newQuantity) == nil
                                                    ? quantity
                                                    : Double(newQuantity)) ?? 0)))

                            listRow(title: "Fiber",
                                    description: String((product?.fiber?
                                        .reseted(quantity) ?? 0)
                                        .dividedBy((Double(newQuantity) == nil
                                                    ? quantity
                                                    : Double(newQuantity)) ?? 0)))

                            listRow(title: "Salt",
                                    description: String((product?.salt?
                                        .reseted(quantity) ?? 0)
                                        .dividedBy((Double(newQuantity) == nil
                                                    ? quantity
                                                    : Double(newQuantity)) ?? 0)))
                        }
                    }
                    Section {
                        HStack {
                            Text("New quantity")
                            Spacer()
                            TextField("100", text: $newQuantity)
                                .multilineTextAlignment(.trailing)
                            Text("g")
                        }
                        Button {
                            if let product = product, let quantity = product.quantity {
                                meal.products.removeAll(where: { $0.id == product.id })
                                meal.products.append(Product(productNameFR: product.productNameFR,
                                                             productNameEN: product.productNameEN,
                                                             quantity: Double(newQuantity) ?? 100,
                                                             carbs: product.carbs?.reseted(quantity).dividedBy(Double(newQuantity) ?? 100),
                                                             calories: product.calories?.reseted(quantity).dividedBy(Double(newQuantity) ?? 100),
                                                             fat: product.fat?.reseted(quantity).dividedBy(Double(newQuantity) ?? 100) ?? 0,
                                                             fiber: product.fiber?.reseted(quantity).dividedBy(Double(newQuantity) ?? 100) ?? 0,
                                                             proteins: product.proteins?.reseted(quantity).dividedBy(Double(newQuantity) ?? 100) ?? 0,
                                                             salt: product.salt?.reseted(quantity).dividedBy(Double(newQuantity) ?? 100) ?? 0,
                                                             saturatedFat: product.saturatedFat?.reseted(quantity).dividedBy(Double(newQuantity) ?? 100) ?? 0,
                                                             sugars: product.sugars?.reseted(quantity).dividedBy(Double(newQuantity) ?? 100) ?? 0
                                                            )
                                )
                            } else {
                                print("no product")
                            }
                            isPresented = false
                        } label: {
                            HStack {
                                Spacer()
                                Text("Save product")
                                Spacer()
                            }
                        }
                    }
                    Section {
                        Button {
                            if let product = product {
                                meal.products.removeAll(where: { $0.id == product.id })
                            } else {
                                print("no product")
                            }
                            isPresented = false
                        } label: {
                            HStack {
                                Spacer()
                                Text("Delete product")
                                    .foregroundStyle(.red)
                                Spacer()
                            }
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

#Preview {
    ProductDetailView(meal: .constant(Meal()), didDissmiss: {} )
}
