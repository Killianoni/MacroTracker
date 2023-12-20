//
//  String+Helpers.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 20/12/2023.
//

import Foundation

extension String {
    func toCGFloat() -> CGFloat? {
        // Utilisez NumberFormatter pour effectuer la conversion
        let formatter = NumberFormatter()
        formatter.locale = Locale.current  // Vous pouvez ajuster cela en fonction de votre besoin
        formatter.numberStyle = .decimal

        if let number = formatter.number(from: self) {
            return CGFloat(truncating: number)
        } else {
            return nil  // La conversion a échoué
        }
    }
}
