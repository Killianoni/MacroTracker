//
//  String+Helpers.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 20/12/2023.
//

import Foundation

extension String {
    func toFloat() -> Float? {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal

        if let number = formatter.number(from: self) {
            return Float(truncating: number)
        } else {
            return nil
        }
    }
}
