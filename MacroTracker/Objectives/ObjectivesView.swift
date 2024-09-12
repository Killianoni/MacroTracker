//
//  ObjectivesView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 15/12/2023.
//

import SwiftUI

// TODO: DEMANDER LES INFOS DU USER ET AJOUTER LA POSSIBILITE DE CUSTOM SES MACROS, HIDE LE CLAVIER
struct ObjectivesView: View {
    @ObservedObject var viewModel = ObjectivesViewModel()
    var body: some View {
        VStack {
            Text("Objectives")
                .font(.title)
            
            Group {
                CustomTextFieldView(text: $viewModel.proteinsText, prompt: "Proteins")
                    .keyboardType(.numberPad)
                
                CustomTextFieldView(text: $viewModel.fatText, prompt: "Fat")
                    .keyboardType(.numberPad)
                
                CustomTextFieldView(text: $viewModel.carbsText, prompt: "Carbs")
                    .keyboardType(.numberPad)
                
                CustomTextFieldView(text: $viewModel.caloriesText, prompt: "Calories (optional)", disableVerification: true)
                    .keyboardType(.numberPad)
            }
            .padding(.vertical)
            
            Spacer()
                .frame(height: 50)
            CustomButtonView(action: {
                viewModel.save()
                UserDefaults.standard.setValue(false, forKey: "isFirstLaunch")
            },label: "Continue", color: .green, width: 150)
            Spacer()
        }
    }
}

#Preview {
    ObjectivesView()
}
