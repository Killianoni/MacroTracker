//
//  ProgressBarView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 15/12/2023.
//

import SwiftUI

struct CustomProgressBar: ProgressViewStyle {
    let number1: CGFloat
    let number2: CGFloat
    let color: Color
    let width: CGFloat
    var title: String
    
    enum Constants {
        static let barHeight: CGFloat = 15
        static let barRadius: CGFloat = 12
        static let barOpacity: CGFloat = 0.3
        static let fontDivider: CGFloat = 5
    }
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: self.width, height: Constants.barHeight)
                    .foregroundColor(self.color.opacity(Constants.barOpacity))
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: number1 > number2 ? self.width : self.width * number1/number2, height: Constants.barHeight)
                    .foregroundColor(self.color)
                    .animation(.easeOut, value: number1)
            }
        }
        HStack {
            Text(title)
            Spacer()
            Text("\(Int(number1)) / \(Int(number2))")
        }
        .frame(width: self.width)
        .bold()
        .sensoryFeedback(.increase, trigger: number1)
    }
}

#Preview {
    ProgressView()
        .progressViewStyle(CustomProgressBar(number1: 50, number2: 2500, color: .purple, width: 200, title: "Calories"))
}
