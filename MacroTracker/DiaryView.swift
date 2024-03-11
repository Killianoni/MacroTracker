//
//  DiaryView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 14/12/2023.
//

import SwiftUI
import SwiftData

struct DiaryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var macros: [Macros]
    @ObservedObject var viewModel = DiaryViewModel()
    
    var body: some View {
        VStack {
            DailyDateView(date: $viewModel.currentDate)
                .onChange(of: viewModel.currentDate) { _ , newValue in
                    viewModel.isNewDay(macros: macros)
                }
            if viewModel.getMacros(macros: macros) != nil {
                HStack {
                    ProgressCircleView(number1: viewModel.getMacros(macros: macros)!.carbs, number2: viewModel.totalCarbs, color: Color.brown, size: 80, title: NSLocalizedString("Carbs", comment: ""))
                    ProgressCircleView(number1: viewModel.getMacros(macros: macros)!.fat, number2: viewModel.totalFat, color: Color.orange, size: 80, title: NSLocalizedString("Fat", comment: ""))
                    ProgressCircleView(number1: viewModel.getMacros(macros: macros)!.proteins, number2: viewModel.totalProteins, color: Color.red, size: 80, title: NSLocalizedString("Proteins", comment: ""))
                }
                
                HStack {
                    ProgressView()
                        .progressViewStyle(CustomProgressBar(number1: viewModel.getMacros(macros: macros)!.calories, number2: viewModel.totalCalories, color: Color.purple, width: 300, title: "Calories"))
                }
                .padding()
                
                if Calendar.current.isDateInToday(viewModel.currentDate) {
                    HStack {
                        IncrementButton(number: $viewModel.incrementCarbs, width: 20, color: Color.brown)
                        IncrementButton(number: $viewModel.incrementFat, width: 20, color: Color.orange)
                        IncrementButton(number: $viewModel.incrementProteins, width: 20, color: Color.red)
                    }
                    
                    HStack {
                        CustomButtonView(action: {
                            viewModel.add(macros: macros)
                        }, label: "Apply", color: Color.blue, width: 200, height: 50)
                    }
                }
                Spacer()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            viewModel.context = modelContext
            viewModel.isNewDay(macros: macros)
            viewModel.refreshDefaults()
        }
    }
}

#Preview {
    DiaryView()
        .modelContainer(for: Macros.self, inMemory: true)
}
