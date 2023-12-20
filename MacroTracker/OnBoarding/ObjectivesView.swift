//
//  ObjectivesView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 15/12/2023.
//

import SwiftUI

struct ObjectivesView: View {
    @ObservedObject var viewModel = ObjectivesViewModel()
    var body: some View {
        VStack {
            Text("Objectifs")
                .font(.title)
            
            Group {
                CustomTextFieldView(text: $viewModel.proteinsText, prompt: "Protéines")
                    .keyboardType(.numberPad)
                
                CustomTextFieldView(text: $viewModel.fatText, prompt: "Lipides")
                    .keyboardType(.numberPad)
                
                CustomTextFieldView(text: $viewModel.carbsText, prompt: "Glucides")
                    .keyboardType(.numberPad)
                
                CustomTextFieldView(text: $viewModel.caloriesText, prompt: "Calories (facultatif)", disableVerification: true)
                    .keyboardType(.numberPad)
            }
            .padding(.vertical)
            
            Spacer()
                .frame(height: 50)
            CustomButtonView(action: {
                viewModel.save()
                UserDefaults.standard.setValue(false, forKey: "isFirstLaunch")
            },label: "Continuer", color: .green, width: 150)
            Spacer()
        }
    }
}

#Preview {
    ObjectivesView()
}
