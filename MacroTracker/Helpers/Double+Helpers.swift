//
//  Double+Helpers.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 26/09/2024.
//

extension Double {
    func dividedBy(_ divisor: Double) -> Double {
        return (self * divisor / 100).rounded()
    }

    func reseted(_ multiplier: Double) -> Double {
        return (self * 100 / multiplier).rounded()
    }
}
