//
//  CustomButtonView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 15/12/2023.
//

import SwiftUI

struct CustomButtonView: View {
    var action: () -> Void
    var label: String
    var color: Color
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            CustomButtonBody(label: self.label, color: self.color, width: self.width, height: self.height)
        })
        .tint(.black)
    }
}

private struct CustomButtonBody: View {
    var label: String
    var color: Color
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        Text(self.label)
            .bold()
            .frame(width: self.width, height: self.height)
            .background(Color(self.color))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

#Preview {
    CustomButtonView(action: {}, label: "Add", color: .green, width: 100, height: 50)
}
