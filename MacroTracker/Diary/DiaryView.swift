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

    var body: some View {
        VStack {
            if viewModel.state == .normal {
                DailyDateView(date: $viewModel.currentDate)
                    .onChange(of: viewModel.currentDate) { _ , newValue in
                        viewModel.load()
                    }

                // Circles
                HStack {
                    ProgressCircleView(number1: $viewModel.macros.carbs,
                                       number2: viewModel.user.carbs,
                                       color: Color.brown,
                                       size: 80,
                                       title: String(localized: "Carbs"))
                    ProgressCircleView(number1: $viewModel.macros.fat,
                                       number2: viewModel.user.fat,
                                       color: Color.orange,
                                       size: 80,
                                       title: String(localized: "Fat"))
                    ProgressCircleView(number1: $viewModel.macros.proteins,
                                       number2: viewModel.user.proteins,
                                       color: Color.red,
                                       size: 80,
                                       title: String(localized: "Proteins"))
                }

                // Calories bar
                HStack {
                    ProgressView()
                        .progressViewStyle(CustomProgressBar(number1: viewModel.macros.calories, number2: viewModel.user.calories, color: Color.purple, width: 300, title: String(localized: "Calories")))
                }
                .padding()

                // Increment buttons
                if viewModel.currentDate.isEqualTo(date: .now) {
                    HStack {
                        IncrementButton(number: $viewModel.incrementCarbs, width: 20, color: Color.brown)
                        IncrementButton(number: $viewModel.incrementFat, width: 20, color: Color.orange)
                        IncrementButton(number: $viewModel.incrementProteins, width: 20, color: Color.red)
                    }
                    .padding(.bottom, 30)

                    // Apply button
                    HStack {
                        CustomButtonView(action: {
                            viewModel.add()
                        }, label: String(localized: "Apply"), color: .green.opacity(0.6), width: 200, height: 50)
                    }
                }
                Spacer()
            } else {
                ProgressView()
            }
        }
        .hideKeyboard()
        .onAppear {
            viewModel.load()
        }
    }
}

#Preview {
    DiaryView()
}
