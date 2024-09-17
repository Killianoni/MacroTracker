//
//  ObjectivesView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 15/12/2023.
//

import SwiftUI
import SwiftData

// TODO: Clavier
struct ObjectivesView: View {
    @AppStorage("shouldShowOnboarding") private var showOnboarding: Bool = true
    @ObservedObject var viewModel = ObjectivesViewModel(dataSource: .shared)
    var body: some View {
        VStack {
            Text("Profile")
                .font(.title)
                .bold()
                .padding()
            VStack(alignment: .leading, spacing: 15) {
                CustomTextFieldView(text: $viewModel.height, title: String(localized: "Height"))
                    .keyboardType(.numberPad)
                CustomTextFieldView(text: $viewModel.weight, title: String(localized: "Weight"))
                    .keyboardType(.numberPad)
                CustomTextFieldView(text: $viewModel.age, title: String(localized: "Age"))
                    .keyboardType(.numberPad)

                Text("Genre")
                    .bold()
                CustomSegmentedControl(preselectedIndex: $viewModel.gender, options: [String(localized: "Man"), String(localized: "Women")])

                Text("Activity")
                    .bold()
                CustomSegmentedControl(preselectedIndex: $viewModel.activity, options: [String(localized: "Sedentary"), String(localized: "Active"), String(localized: "Very Active"), String(localized: "Extremely Active")])

                Text("Objectives")
                    .bold()
                CustomSegmentedControl(preselectedIndex: $viewModel.objectives, options: [String(localized: "Cut"), String(localized: "Maintain"), String(localized: "Bulk")])
            }
            .padding(.horizontal, 40)

            Spacer()
                .frame(height: 50)

            VStack(alignment: .center) {
                CustomButtonView(action: {
                    viewModel.save()
                    showOnboarding = false
                },label: String(localized: "Continue"), color: .green.opacity(0.6), width: 150)
            }
            Spacer()
        }
        .hideKeyboard()
    }
}

#Preview {
    ObjectivesView()
}

struct CustomSegmentedControl: View {
    @Binding var preselectedIndex: Int
    var options: [String]
    let color = Color.green

    var body: some View {
        HStack(spacing: 0) {
            ForEach(options.indices, id:\.self) { index in
                ZStack {
                    Rectangle()
                        .fill(color.opacity(0.2))

                    Rectangle()
                        .fill(color.opacity(0.6))
                        .cornerRadius(12)
                        .padding(2)
                        .opacity(preselectedIndex == index ? 1 : 0.01)
                        .onTapGesture {
                            withAnimation(.interactiveSpring) {
                                preselectedIndex = index
                            }
                        }
                }
                .overlay(
                    Text(options[index])
                        .font(.system(size: options.count >= 4 ? 12 : 16))
                        .bold()
                )
            }
        }
        .frame(height: 45)
        .cornerRadius(14)
    }
}
