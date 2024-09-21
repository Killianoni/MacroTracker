//
//  SettingsView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 11/03/2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
            Section {
                HStack {
                    Image(systemName: "globe")
                    Text("Language")
                    Spacer()
                    Button(action: {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    }, label: {
                        Text(Locale.current.identifier.contains("fr") ? "French" : "English")
                    })
                }
            } header: {
                Text("Preferences")
            }
        }
        .background(.backgroundTint)
    }
}

struct editableFormField: View {
    var label: String
    @Binding var value: String
    
    init(_ label: String, value: Binding<String>) {
        self.label = label
        self._value = value
    }
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            TextField("", text: $value, onCommit: {
                UserDefaults.standard.set(value, forKey: label.lowercased())
            })
            .frame(width: 50)
            .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    SettingsView()
}
