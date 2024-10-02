//
//  MealView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 23/09/2024.
//

import SwiftUI

struct MealView: View {
    @Binding var meal: Meal
    @State private var isOpen: Bool = false
    @State private var showEditProduct: Bool = false
    @State private var showAddProduct: Bool = false
    @State private var product: Product?
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(meal.name)
                        .font(.system(size: 16, weight: .bold))
                    Text(String(meal.getCalories()))
                        .font(.system(size: 14, weight: .regular))
                }
                Spacer()
                HStack {
                    Text(String(meal.getProtein()))
                    Text(String(meal.getCarbs()))
                    Text(String(meal.getFat()))
                }
                .font(.system(size: 14, weight: .bold))
                Image(systemName: "chevron.right")
                    .rotationEffect(.degrees(isOpen ? 90 : 0))
                    .padding(.leading, 40)
                    .padding(.trailing, 10)
            }
            .padding()
            .background(
                CornerRadiusShape(corners: [!isOpen ? .allCorners : .topLeft, .topRight], radius: 12)
                    .foregroundStyle(.cardTint)
                    .opacity(0.7)
                    .overlay(
                        CornerRadiusShape(corners: [!isOpen ? .allCorners : .topLeft, .topRight], radius: 12)
                            .stroke(.shadowTint.opacity(0.3), lineWidth: 0.6)
                    )
            )
            .onTapGesture {
                withAnimation {
                    isOpen.toggle()
                }
            }
            if isOpen {
                VStack(spacing: 20) {
                    ForEach(meal.products, id: \.self) { product in
                        HStack {
                            Button {
                                self.product = product
                                showEditProduct = true
                            } label: {
                                Text(product.productNameFR ?? "")
                                    .font(.system(size: 16, weight: .bold))
                                Text(String(product.quantity ?? 100) + "g")
                                    .font(.system(size: 14, weight: .regular))
                                Spacer()
                                HStack {
                                    Text(String(product.proteins ?? 0))
                                    Text(String(product.carbs ?? 0))
                                    Text(String(product.fat ?? 0))
                                }
                                .multilineTextAlignment(.trailing)
                                .font(.system(size: 14, weight: .bold))
                                .padding(.trailing, 10)
                                Text(String(product.calories ?? 0))
                                    .font(.system(size: 14, weight: .regular))
                                    .frame(width: 40)

                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    Button {
                        showAddProduct = true
                    } label: {
                        Spacer()
                        Text("Add a product +")
                            .font(.system(size: 14, weight: .bold))
                        Spacer()
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.trailing, 10)
                .transition(.blurReplace)
                .padding()
                .background(
                    CornerRadiusShape(corners: [.bottomLeft, .bottomRight], radius: 12)
                        .foregroundStyle(.cardTint)
                        .opacity(0.7)
                        .overlay(
                            CornerRadiusShape(corners: [.bottomLeft, .bottomRight], radius: 12)
                                .stroke(.shadowTint.opacity(0.3), lineWidth: 0.6)
                        )
                )
                .sheet(isPresented: $showEditProduct) {
                    EditProductView(product: $product, meal: $meal, isPresented: $showEditProduct)
                }
                .sheet(isPresented: $showAddProduct) {
                    AddProductView(isPresented: $showAddProduct, meal: $meal)
                }
            }
        }
        .sensoryFeedback(.impact, trigger: isOpen)
        .sensoryFeedback(.selection, trigger: showAddProduct)
        .sensoryFeedback(.selection, trigger: showEditProduct)
    }
}

#Preview {
    MealView(meal: .constant(Meal(name: "Breakfast", date: Date(), products: getRandomProducts())))
}

private func getRandomProducts() -> [Product] {
    let numberOfProducts = Int.random(in: 1...5)
    var products: [Product] = []

    for _ in 1...numberOfProducts {
        let randomNum = Int.random(in: 1...5)

        let product = getProduct(by: randomNum)
        products.append(product)
    }

    return products
}

private func getProduct(by number: Int) -> Product {
    switch number {
        case 1:
            return Product(productNameFR: "Pain de mie", productNameEN: "Sliced bread", carbs: 50, calories: 150, fat: 2, fiber: 1, proteins: 4, salt: 0.5, saturatedFat: 0.1, sugars: 3)
        case 2:
            return Product(productNameFR: "Croissant", productNameEN: "Croissant", carbs: 25, calories: 300, fat: 17, fiber: 1, proteins: 5, salt: 0.4, saturatedFat: 10, sugars: 5)
        case 3:
            return Product(productNameFR: "Baguette", productNameEN: "Baguette", carbs: 60, calories: 250, fat: 1, fiber: 2, proteins: 8, salt: 0.6, saturatedFat: 0.1, sugars: 1)
        case 4:
            return Product(productNameFR: "Pain complet", productNameEN: "Whole wheat bread", carbs: 45, calories: 200, fat: 3, fiber: 5, proteins: 6, salt: 0.7, saturatedFat: 0.2, sugars: 2)
        case 5:
            return Product(productNameFR: "Brioche", productNameEN: "Brioche", carbs: 55, calories: 330, fat: 12, fiber: 1, proteins: 7, salt: 0.3, saturatedFat: 5, sugars: 8)
        default:
            return Product(productNameFR: "", productNameEN: "", carbs: 0, calories: 0, fat: 0, fiber: 0, proteins: 0, salt: 0, saturatedFat: 0, sugars: 0)
    }
}
