//
//  DiaryView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 14/12/2023.
//

import SwiftUI
import SwiftData

// TODO: FAIRE FONCTIONNER LA PREVIEW, LE ONAPPEAR AUSSI CEST QUOI CA, ET CLAVIER IMPORTANT, FAIRE UN STATE DE LOADING PITIE
struct DiaryView: View {
    @StateObject var viewModel = DiaryViewModel(dataSource: .shared)

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
                                       title: NSLocalizedString("Carbs", comment: ""))
                    ProgressCircleView(number1: $viewModel.macros.fat,
                                       number2: viewModel.user.fat,
                                       color: Color.orange,
                                       size: 80,
                                       title: NSLocalizedString("Fat", comment: ""))
                    ProgressCircleView(number1: $viewModel.macros.proteins,
                                       number2: viewModel.user.proteins,
                                       color: Color.red,
                                       size: 80,
                                       title: NSLocalizedString("Proteins", comment: ""))
                }

                // Calories bar
                HStack {
                    ProgressView()
                        .progressViewStyle(CustomProgressBar(number1: viewModel.macros.calories, number2: viewModel.user.calories, color: Color.purple, width: 300, title: "Calories"))
                }
                .padding()

                // Increment buttons
                if viewModel.currentDate.isEqualTo(date: .now) {
                    HStack {
                        IncrementButton(number: $viewModel.incrementCarbs, width: 20, color: Color.brown)
                        IncrementButton(number: $viewModel.incrementFat, width: 20, color: Color.orange)
                        IncrementButton(number: $viewModel.incrementProteins, width: 20, color: Color.red)
                    }

                    // Apply button
                    HStack {
                        CustomButtonView(action: {
                            viewModel.add()
                        }, label: String(localized: "Apply"), color: Color.blue, width: 200, height: 50)
                    }
                }
                Spacer()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            viewModel.load()
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

#Preview {
    DiaryView()
}