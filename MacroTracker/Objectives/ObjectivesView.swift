//
//  ObjectivesView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 15/12/2023.
//

import SwiftUI

// TODO: DEMANDER LES INFOS DU USER ET AJOUTER LA POSSIBILITE DE CUSTOM SES MACROS, HIDE LE CLAVIER
struct ObjectivesView: View {
    @AppStorage("shouldShowOnboarding") var showOnboarding: Bool = true
    @ObservedObject var viewModel = ObjectivesViewModel(dataSource: .shared)
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(alignment: .center) {
            Text("Profile")
                .font(.title)
                .bold()
                .padding()

//            CustomTextFieldView(text: $viewModel.height, prompt: "Taille")
//            CustomTextFieldView(text: $viewModel.weight, prompt: "Poids")
//            CustomTextFieldView(text: $viewModel.age, prompt: "Âge")

            Spacer()
                .frame(height: 50)

            CustomButtonView(action: {
                viewModel.save()
                showOnboarding = false
            },label: "Continue", color: .blue, width: 150)
            Spacer()
        }
    }
}

#Preview {
    ObjectivesView()
}
