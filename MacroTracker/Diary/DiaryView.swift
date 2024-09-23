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
            if !viewModel.state.isLoading {
                DailyDateView(date: $viewModel.currentDate)
                    .onChange(of: viewModel.currentDate) { _ , newValue in
                        viewModel.load()
                    }
                    .padding(.top, 30)

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
                .padding(.vertical, 15)

                // Calories bar
                HStack {
                    ProgressView()
                        .progressViewStyle(CustomProgressBar(number1: viewModel.stepCount, number2: 10000, color: .red, title: String(localized: "Steps")))
                }
                .padding(.bottom, 15)
                HStack {
                    ProgressView()
                        .progressViewStyle(CustomProgressBar(number1: viewModel.macros.calories, number2: viewModel.user.calories, color: .green, title: String(localized: "Calories")))
                }
                Spacer()
            } else {
                ProgressView()
            }
        }
        .padding(.horizontal, 30)
        .onAppear {
            viewModel.load()
        }
    }
}

#Preview {
    DiaryView()
}
