//
//  ProgressCircleView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 14/12/2023.
//

import SwiftUI

struct ProgressCircleView: View {
    
    @Binding var number1: Float
    let number2: Float
    let color: Color
    var title: String?
    
    enum Constants {
        static let lineWidth: CGFloat = 8
        static let circleOpacity: CGFloat = 0.3
        static let rotationDegrees: CGFloat = -90
        static let fontDivider: CGFloat = 5
    }
    var body: some View {
        VStack {
            ZStack {
                // Base circle
                Circle()
                    .stroke(
                        self.color.opacity(Constants.circleOpacity),
                        lineWidth: Constants.lineWidth
                    )
                if let title = self.title {
                    Text(title.prefix(1))
                        .font(.system(size: 16))
                        .bold()
                }
                // Progress circle
                Circle()
                    .trim(from: 0, to: CGFloat(number1/number2))
                    .stroke(
                        self.color,
                        style: StrokeStyle(
                            lineWidth: Constants.lineWidth,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(Constants.rotationDegrees))
                    .animation(.easeOut(duration: 1), value: number1)
            }
            .frame(width: 55)
            .padding(.bottom, 5)
            Text("\(Int(number1)) / \(Int(number2))")
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .font(.system(size: 14))
                .bold()
        }
        .frame(width: 100, height: 100)
        .sensoryFeedback(.increase, trigger: number1)
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
    HStack {
        ProgressCircleView(number1: .constant(200), number2: 2500, color: .cyan, title: "Proteines")
        ProgressCircleView(number1: .constant(200), number2: 2500, color: .cyan, title: "Proteines")
        ProgressCircleView(number1: .constant(200), number2: 2500, color: .cyan, title: "Proteines")
    }
    .padding(.horizontal, 30)
}
