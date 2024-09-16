//
//  View+Helpers.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 11/09/2024.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() -> some View {
        modifier(hideKeyboardModifier())
    }
}

struct hideKeyboardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.white.opacity(0.01))
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
    }
}
