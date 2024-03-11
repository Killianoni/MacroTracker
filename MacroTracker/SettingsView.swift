//
//  SettingsView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 11/03/2024.
//

import SwiftUI

struct SettingsView: View {    
    @State private var proteins: String = UserDefaults.standard.string(forKey: "proteins") ?? ""
    @State private var carbs: String = UserDefaults.standard.string(forKey: "carbs") ?? ""
    @State private var fat: String = UserDefaults.standard.string(forKey: "fat") ?? ""
    @State private var calories: String = UserDefaults.standard.string(forKey: "calories") ?? ""
    
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Image(systemName: "globe")
                    Text("Language")
                }
                HStack {
                    Image(systemName: "moon")
                    Toggle(isOn: .constant(true)) {
                        Text("Dark Mode")
                    }
                }
            } header: {
                Text("PREFERENCES")
            }
            
            Section {
                editableFormField("Proteins", value: $proteins)
                editableFormField("Carbs", value: $carbs)
                editableFormField("Fat", value: $fat)
                editableFormField("Calories", value: $calories)
            } header: {
                Text("MACROS")
            }
        }
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
