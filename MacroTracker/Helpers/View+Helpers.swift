//
//  View+Helpers.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 11/09/2024.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
