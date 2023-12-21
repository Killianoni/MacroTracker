//
//  DailyDateView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 20/12/2023.
//

import SwiftUI

struct DailyDateView: View {
    @Binding var date: Date
    
    private enum Constants {
        static let spacerWidth: CGFloat = 60
        static let chevronWidth: CGFloat = 15
    }
    var body: some View {
        HStack {
            Button {
                if let newDate = date.decrement(by: 1, component: .day) {
                    date = newDate
                }
            } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.primary)
                    .scaledToFit()
                    .frame(width: Constants.chevronWidth)
            }
            Spacer()
                .frame(width: Constants.spacerWidth)
            Text(date.formattedString())
                .lineLimit(1)
                .font(.title3)
                .bold()
            Spacer()
                .frame(width: Constants.spacerWidth)
            Button {
                if let newDate = date.increment(by: 1, component: .day) {
                    date = newDate
                }
            } label: {
                Image(systemName: "chevron.right")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.primary)
                    .scaledToFit()
                    .frame(width: Constants.chevronWidth)
            }
        }
    }
}

#Preview {
    DailyDateView(date: .constant(.now))
}
