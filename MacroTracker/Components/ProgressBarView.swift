//
//  ProgressBarView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 15/12/2023.
//

import SwiftUI

struct CustomProgressBar: ProgressViewStyle {
    let number1: Float
    let number2: Float
    let color: Color
    var title: String
    
    enum Constants {
        static let barHeight: CGFloat = 18
        static let barRadius: CGFloat = 12
        static let barOpacity: CGFloat = 0.3
        static let fontDivider: CGFloat = 5
    }
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            HStack {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(maxWidth: UIScreen.main.bounds.size.width, maxHeight: Constants.barHeight)
                        .foregroundColor(self.color.opacity(Constants.barOpacity))
                    RoundedRectangle(cornerRadius: 12)
                        .frame(maxWidth: number1 > number2 ? UIScreen.main.bounds.size.width : UIScreen.main.bounds.size.width * CGFloat(number1/number2), maxHeight: Constants.barHeight)
                        .foregroundColor(self.color.opacity(0.6))
                        .animation(.easeOut(duration: 1), value: number1)
                }
            }
            HStack {
                Text(title)
                Spacer()
                Text("\(Int(number1)) / \(Int(number2))")
            }
            .frame(width: 300)
            .bold()
            .sensoryFeedback(.increase, trigger: number1)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(.cardTint)
            .opacity(0.7)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.shadowTint.opacity(0.3), lineWidth: 0.5)
            )
        )
    }
}

#Preview {
    ProgressView()
        .progressViewStyle(CustomProgressBar(number1: 2000, number2: 2500, color: .green, title: "Calories"))
}
