//
//  DiaryView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 14/12/2023.
//

import SwiftUI
import SwiftData

// TODO: FAIRE FONCTIONNER LA PREVIEW ET VIRER LE GETMACROS ZEBI, LE ONAPPEAR AUSSI CEST QUOI CA, ET CLAVIER IMPORTANT, FAIRE UN STATE DE LOADING PITIE
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
                    ProgressCircleView(number1: viewModel.getMacros(macros: macros)!.carbs, 
                                       number2: viewModel.totalCarbs,
                                       color: Color.brown,
                                       size: 80,
                                       title: NSLocalizedString("Carbs", comment: ""))
                    ProgressCircleView(number1: viewModel.getMacros(macros: macros)!.fat, 
                                       number2: viewModel.totalFat, 
                                       color: Color.orange,
                                       size: 80,
                                       title: NSLocalizedString("Fat", comment: ""))
                    ProgressCircleView(number1: viewModel.getMacros(macros: macros)!.proteins, 
                                       number2: viewModel.totalProteins,
                                       color: Color.red,
                                       size: 80,
                                       title: NSLocalizedString("Proteins", comment: ""))
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
                        }, label: String(localized: "Apply"), color: Color.blue, width: 200, height: 50)
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
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Macros.self,
                                           configurations: .init(isStoredInMemoryOnly: true))
        container.mainContext.insert(Macros(id: "2", date: .now, fat: 10, carbs: 10,proteins: 10,calories: 10))
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()


#Preview {
    DiaryView()
        .modelContainer(previewContainer)
}
