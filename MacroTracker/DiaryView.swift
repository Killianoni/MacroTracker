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
            HStack {
                Text("Aujourd'hui")
                    .font(.system(size: 25))
                    .bold()
            }
            if let dailyMacros = viewModel.dailyMacros {
                HStack {
                    ProgressCircleView(number1: dailyMacros.carbs, number2: viewModel.totalCarbs, color: Color.brown, size: 80, title: NSLocalizedString("Carbs", comment: ""))
                    ProgressCircleView(number1: dailyMacros.fat, number2: viewModel.totalFat, color: Color.orange, size: 80, title: NSLocalizedString("Fat", comment: ""))
                    ProgressCircleView(number1: dailyMacros.proteins, number2: viewModel.totalProteins, color: Color.red, size: 80, title: NSLocalizedString("Proteins", comment: ""))
                }
                
                HStack {
                    ProgressView()
                        .progressViewStyle(CustomProgressBar(number1: dailyMacros.calories, number2: viewModel.totalCalories, color: Color.purple, width: 300, title: "Calories"))
                }
                .padding()
                
                HStack {
                    IncrementButton(number: $viewModel.incrementCarbs, width: 20, color: Color.brown)
                    IncrementButton(number: $viewModel.incrementFat, width: 20, color: Color.orange)
                    IncrementButton(number: $viewModel.incrementProteins, width: 20, color: Color.red)
                }
                
                HStack {
                    CustomButtonView(action: {
                        viewModel.add()
                    }, label: "Appliquer", color: Color.blue, width: 200, height: 50)
                }
            } else {
                Button {
                    viewModel.insert()
                } label: {
                    Text("Insert")
                }
            }
            Spacer()
        }
        .onAppear {
            viewModel.dailyMacros = macros.first(where: { Calendar.current.isDate($0.date, equalTo: Date.now, toGranularity: .day) }) ?? nil
            viewModel.context = modelContext
        }
    }
}

#Preview {
    DiaryView()
        .modelContainer(for: Macros.self, inMemory: true)
}
