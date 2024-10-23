//
//  DiaryView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 14/12/2023.
//

import SwiftUI
import SwiftData
import CodeScanner

struct DiaryView: View {
    @StateObject private var viewModel = DiaryViewModel(dataSource: .shared)
    @Binding var onboardingShowing: Bool
    @State private var showAddMeal: Bool = false
    var body: some View {
        VStack {
            if !viewModel.state.isLoading {
                DailyDateView(date: $viewModel.currentDate)
                    .onChange(of: viewModel.currentDate) { _, _ in
                        viewModel.load()
                    }
                    .padding(.top, 30)
                    .onLongPressGesture {
                        viewModel.currentDate = .now
                    }
                if let user = viewModel.user {
                    ScrollView(showsIndicators: false) {
                        // Circles
                        HStack(spacing: 0) {
                            ProgressCircleView(number1: viewModel.getAllProteins(),
                                               number2: user.proteins,
                                               color: .red,
                                               title: String(localized: "Proteins"))
                            Spacer()
                            ProgressCircleView(number1: viewModel.getAllCarbs(),
                                               number2: user.carbs,
                                               color: .orange,
                                               title: String(localized: "Carbs"))
                            Spacer()
                            ProgressCircleView(number1: viewModel.getAllFat(),
                                               number2: user.fat,
                                               color: Color.yellow,
                                               title: String(localized: "Fat"))
                        }
                        .padding(.vertical, 10)

                        // Steps bar
                        HStack {
                            ProgressView()
                                .progressViewStyle(CustomProgressBar(number1: viewModel.stepCount, number2: user.steps, color: .red, title: String(localized: "Steps")))
                        }
                        .padding(.bottom, 10)

                        // Calories bar
                        HStack {
                            ProgressView()
                                .progressViewStyle(CustomProgressBar(number1: viewModel.getAllCalories(), number2: user.calories, color: .green, title: String(localized: "Calories")))
                        }
                        .padding(.bottom, 30)

                        // Meals
                        ForEach($viewModel.meals) { meal in
                            MealView(meal: meal)
                        }
                        .padding(.bottom, 10)
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
                }
            } else {
                ProgressView()
            }
        }
        .padding(.horizontal, 30)
        .onAppear {
            viewModel.load()
        }
        .onChange(of: onboardingShowing) { _, _ in
            viewModel.load()
        }
        .hideKeyboard()
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onEnded({ value in
                if value.translation.width > 0 {
                    withAnimation {
                        viewModel.currentDate = viewModel.currentDate.decrement(by: 1, component: .day) ?? .now
                    }
                }

                if value.translation.width < 0 {
                    withAnimation {
                        viewModel.currentDate = viewModel.currentDate.increment(by: 1, component: .day) ?? .now
                    }
                }
            }))
        .sensoryFeedback(.selection, trigger: showAddMeal)
    }
}

#Preview {
    DiaryView(onboardingShowing: .constant(false))
}
