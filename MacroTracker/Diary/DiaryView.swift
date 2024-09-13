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
    @Environment(\.modelContext) private var modelContext
    @Query var macrosArray: [Macros]
    var macros: Macros {
        macrosArray.first(where: { Calendar.current.isDate($0.date, equalTo: viewModel.currentDate, toGranularity: .day) }) ?? Macros()
    }
    @ObservedObject var viewModel = DiaryViewModel()

    var body: some View {
        VStack {
            DailyDateView(date: $viewModel.currentDate)
                .onChange(of: viewModel.currentDate) { _ , newValue in
                    viewModel.isNewDate(macros: macrosArray)
                }

            // Circles
            HStack {
                ProgressCircleView(number1: macros.carbs,
                                   number2: viewModel.totalCarbs,
                                   color: Color.brown,
                                   size: 80,
                                   title: NSLocalizedString("Carbs", comment: ""))
                ProgressCircleView(number1: macros.fat,
                                   number2: viewModel.totalFat,
                                   color: Color.orange,
                                   size: 80,
                                   title: NSLocalizedString("Fat", comment: ""))
                ProgressCircleView(number1: macros.proteins,
                                   number2: viewModel.totalProteins,
                                   color: Color.red,
                                   size: 80,
                                   title: NSLocalizedString("Proteins", comment: ""))
            }

            // Calories bar
            HStack {
                ProgressView()
                    .progressViewStyle(CustomProgressBar(number1: macros.calories, number2: viewModel.totalCalories, color: Color.purple, width: 300, title: "Calories"))
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
                        viewModel.add(macros: macros)
                    }, label: String(localized: "Apply"), color: Color.blue, width: 200, height: 50)
                }
            }
            Spacer()
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

#Preview {
    DiaryView()
}
