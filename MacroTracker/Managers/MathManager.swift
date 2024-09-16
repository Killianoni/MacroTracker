//
//  MathManager.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 15/09/2024.
//

import Foundation

final class MathManager {
    let carbsMultiplier: Float = 4
    let proteinsMultiplier: Float = 4
    let fatMultiplier: Float = 9

    func getBasalMetabolicRate(user: User) -> Float {
        if user.gender == .female {
            return (user.weight * 10 + user.height * 6.25 - user.age * 5 - 161)
        }
        return (user.weight * 10 + user.height * 6.25 - user.age * 5 + 5)
    }

    func getDailyEnergieExpenditure(user: User) -> Float {
        switch user.activity {
            case .sedentary:
                return getBasalMetabolicRate(user: user) * 1.2
            case .lowActivity:
                return getBasalMetabolicRate(user: user) * 1.4
            case .highActivity:
                return getBasalMetabolicRate(user: user) * 1.6
            case .insaneActivity:
                return getBasalMetabolicRate(user: user) * 1.8
        }
    }

    func getDailyCalories(user: User) -> Float {
        switch user.type {
            case .bulk:
                return (getDailyEnergieExpenditure(user: user) * 1.15)
            case .cut:
                return (getDailyEnergieExpenditure(user: user) * 0.85)
            case .maintain:
                return getDailyEnergieExpenditure(user: user)
        }
    }

    // [Proteins, Carbs, Fat]
    func getMacros(user: User) -> [String: Float] {
        let calories = getDailyCalories(user: user)
        switch user.type {
            case .bulk:
                return ["proteins": calories * 0.25 / proteinsMultiplier, "carbs": calories * 0.5 / carbsMultiplier, "fat": calories * 0.25 / fatMultiplier]
            case .cut:
                return ["proteins": calories * 0.30 / proteinsMultiplier, "carbs": calories * 0.5 / carbsMultiplier, "fat": calories * 0.20 / fatMultiplier]
            case .maintain:
                return ["proteins": calories * 0.25 / proteinsMultiplier, "carbs": calories * 0.5 / carbsMultiplier, "fat": calories * 0.25 / fatMultiplier]
        }
    }
}
