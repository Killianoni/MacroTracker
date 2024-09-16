//
//  CustomTextFieldView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 15/12/2023.
//

import SwiftUI

struct CustomTextFieldView: View {
    @Binding var text: String
    @State private var status: TextfieldStatus = .unselected
    @State var errorMessage: String?
    let title: String
    var prompt: String?
    var width: CGFloat
    var height: CGFloat
    var disableVerification: Bool
    var isIntField: Bool
    
    init(text: Binding<String>, title: String = "", prompt: String? = nil, width: CGFloat = 300, height: CGFloat = 50, disableVerification: Bool = false, isIntField: Bool = true) {
        self._text = text
        self.title = title
        self.prompt = prompt
        self.width = width
        self.height = height
        self.disableVerification = disableVerification
        self.isIntField = isIntField
    }
    
    private func emptyCheck() {
        self.errorMessage = nil
        self.status = .unselected
        if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.errorMessage = "Le champ ne peut pas etre vide"
            self.status = .error
        }
    }
    
    private func intCheck() {
        self.errorMessage = nil
        self.status = .unselected
        guard Int(text) != nil else {
            self.errorMessage = "Le champ doit seulement contenir des chiffres"
            self.status = .error
            return
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(String(title))
                .bold()
            TextField(prompt ?? "Saisissez votre texte ici", text: $text, onEditingChanged: { editing in
                switch editing {
                case true:
                    self.status = .selected
                case false:
                    self.status = .unselected
                    if !disableVerification {
                        withAnimation {
                            emptyCheck()
                        }
                    }
                    if isIntField {
                        withAnimation {
                            intCheck()
                        }
                    }
                }})
            .modifier(HighlightTextField(status: $status))
            .frame(width: width, height: height)
            Spacer()
                .frame(height: 5)
            if errorMessage != nil {
                Text(self.errorMessage!)
                    .font(.subheadline)
                    .padding(.leading, 5)
            }
        }
    }
}

#Preview {
    CustomTextFieldView(text: .constant(""),title: "Height", prompt: "Mignon textfield")
}

struct HighlightTextField: ViewModifier {
    @Binding fileprivate var status: TextfieldStatus
    
    private func border() -> some View {
        switch status {
        case .selected:
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.blue, lineWidth: 2)
        case .unselected:
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 1)
        case .error:
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.red, lineWidth: 2)
        }
    }

    func body(content: Content) -> some View {
        content
            .padding()
            .autocorrectionDisabled()
            .bold()
            .overlay(
                border()
            )
    }
}

private enum TextfieldStatus {
    case selected
    case unselected
    case error
}
