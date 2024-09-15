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
    let size: CGFloat
    var title: String?
    
    enum Constants {
        static let lineWidth: CGFloat = 10
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

                Text("\(Int(number1)) /\n\(Int(number2))")
                    .multilineTextAlignment(.center)
                    .font(.system(size: size/Constants.fontDivider))
                    .bold()
            }
            .frame(width: size, height: size)
            .padding(.bottom, 5)
            if let title = self.title {
                Text(title)
                    .font(.system(size: size/Constants.fontDivider))
                    .bold()
            }
        }
        .sensoryFeedback(.increase, trigger: number1)
        .padding()
    }
}

#Preview {
    ProgressCircleView(number1: .constant(200), number2: 2500, color: .cyan, size: 200)
}
