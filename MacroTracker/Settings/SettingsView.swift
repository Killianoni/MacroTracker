//
//  SettingsView.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 11/03/2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var healthKitManager = HealthKitManager.shared

    var body: some View {
        Form {
            Section {
                HStack {
                    Image(systemName: "globe")
                        .foregroundStyle(.brown)
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

                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                    Text("Steps tracking")
                    Spacer()
                    Button(action: {
                        if let url = URL(string: "x-apple-health://") {
                            UIApplication.shared.open(url)
                        }
                    }, label: {
                        Circle()
                            .stroke(lineWidth: 2.0)
                            .fill(.red)
                            .overlay {
                                Circle()
                                    .stroke(lineWidth: 4.0)
                                    .fill(.red)
                                    .blur(radius: 3.0)
                            }
                            .frame(width: 15)
                    })
                }
            } header: {
                Text("Preferences")
            }
        }
        .background(.backgroundTint)
        .onAppear {
            print(healthKitManager.isTrackingAuthorized())
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
