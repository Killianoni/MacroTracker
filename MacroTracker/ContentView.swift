//
//  ContentView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 14/12/2023.
//

import SwiftUI
import SwiftData

struct DiaryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var macros: [Macros]
    var dailyMacros: Macros? {
        macros.first(where: { Calendar.current.isDate($0.date, equalTo: Date.now, toGranularity: .day) }) ?? nil
    }
    
    @State var incrementCarbs: CGFloat = 0
    @State var incrementProteins: CGFloat = 0
    @State var incrementFat: CGFloat = 0
    
    private func insert() {
        modelContext.insert(Macros(date: Date.now, fat: 0, carbs: 0, proteins: 0))
    }
    
    private func add() {
        dailyMacros?.carbs += incrementCarbs
        dailyMacros?.fat += incrementFat
        dailyMacros?.proteins += incrementProteins
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Aujourd'hui")
                    .font(.system(size: 25))
                    .bold()
            }
            if let dailyMacros = dailyMacros {
                HStack {
                    ProgressCircleView(number1: dailyMacros.carbs, number2: 180, color: Color.brown, size: 80, title: NSLocalizedString("Carbs", comment: ""))
                    ProgressCircleView(number1: dailyMacros.fat, number2: 80, color: Color.orange, size: 80, title: NSLocalizedString("Fat", comment: ""))
                    ProgressCircleView(number1: dailyMacros.proteins, number2: 200, color: Color.red, size: 80, title: NSLocalizedString("Proteins", comment: ""))
                }
                
                HStack {
                    ProgressView()
                        .progressViewStyle(CustomProgressBar(number1: dailyMacros.calories, number2: 2500, color: Color.purple, width: 300, title: "Calories"))
                }
                .padding()
                
                HStack {
                    IncrementButton(number: $incrementCarbs, width: 20, color: Color.brown)
                    IncrementButton(number: $incrementFat, width: 20, color: Color.orange)
                    IncrementButton(number: $incrementProteins, width: 20, color: Color.red)
                }
                
                HStack {
                    CustomButtonView(action: {
                        add()
                    }, label: "Appliquer", color: Color.blue, width: 200, height: 50)
                }
            } else {
                Button {
                    self.insert()
                } label: {
                    Text("Insert")
                }
            }
            Spacer()
        }
    }
}

#Preview {
    DiaryView()
        .modelContainer(for: Macros.self, inMemory: true)
}
