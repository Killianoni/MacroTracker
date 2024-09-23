//
//  Tabbar.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 11/03/2024.
//

import SwiftUI
import UIKit

struct TabbarView: View {
    @State private var selectedTab = 0
    let feedback = UIImpactFeedbackGenerator(style: .light)

    var body: some View {
        TabView(selection: $selectedTab) {
            DiaryView()
                .tabItem {
                    Label("Diary", systemImage: "chart.bar.xaxis")
                }
                .tag(0)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(1)
        }
        .onChange(of: selectedTab) { _,_ in
            feedback.impactOccurred()
        }
    }
}

#Preview {
    TabbarView()
}
