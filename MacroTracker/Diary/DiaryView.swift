//
//  DiaryView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 14/12/2023.
//

import SwiftUI
import SwiftData
import CodeScanner

// TODO: Clavier
struct DiaryView: View {
    @StateObject private var viewModel = DiaryViewModel(dataSource: .shared)
    @State private var showAddMeal: Bool = false
    var body: some View {
        VStack {
            if !viewModel.state.isLoading {
                DailyDateView(date: $viewModel.currentDate)
                    .onChange(of: viewModel.currentDate) { _, _ in
                        viewModel.load()
                    }
                    .padding(.top, 30)

                ScrollView(showsIndicators: false) {
                // Circles
                HStack(spacing: 0) {
                    ProgressCircleView(number1: $viewModel.macros.proteins,
                                       number2: viewModel.user.proteins,
                                       color: .red,
                                       title: String(localized: "Proteins"))
                    Spacer()
                    ProgressCircleView(number1: $viewModel.macros.carbs,
                                       number2: viewModel.user.carbs,
                                       color: .orange,
                                       title: String(localized: "Carbs"))
                    Spacer()
                    ProgressCircleView(number1: $viewModel.macros.fat,
                                       number2: viewModel.user.fat,
                                       color: Color.yellow,
                                       title: String(localized: "Fat"))
                }
                .padding(.vertical, 10)

                // Steps bar
                HStack {
                    ProgressView()
                        .progressViewStyle(CustomProgressBar(number1: viewModel.stepCount, number2: 10000, color: .red, title: String(localized: "Steps")))
                }
                .padding(.bottom, 10)

                // Calories bar
                HStack {
                    ProgressView()
                        .progressViewStyle(CustomProgressBar(number1: viewModel.macros.calories, number2: viewModel.user.calories, color: .green, title: String(localized: "Calories")))
                }
                .padding(.bottom, 30)
                    MealView()
                    MealView()
                    MealView()
                        .padding(.bottom, 30)
                    Button {
                        showAddMeal = true
                    } label: {
                        Text("Add a meal +")
                            .font(.system(size: 14, weight: .bold))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.bottom, 30)
                .sheet(isPresented: $showAddMeal) {
                    viewModel.load()
                } content: {
                    Text("Add a meal")
                }
            } else {
                ProgressView()
            }
        }
        .padding(.horizontal, 30)
        .onAppear {
            viewModel.load()
        }
        .hideKeyboard()
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onEnded({ value in
                if value.translation.width > 0 {
                    viewModel.currentDate = viewModel.currentDate.decrement(by: 1, component: .day) ?? .now
                }

                if value.translation.width < 0 {
                    viewModel.currentDate = viewModel.currentDate.increment(by: 1, component: .day) ?? .now
                }
            }))
        .sensoryFeedback(.selection, trigger: showAddMeal)
    }
}

#Preview {
    DiaryView()
}
