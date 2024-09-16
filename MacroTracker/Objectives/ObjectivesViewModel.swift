//
//  ObjectivesViewModel.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 15/12/2023.
//

import Foundation

// TODO: Check les entrées des champs
class ObjectivesViewModel: ObservableObject {
    @Published var height: String = ""
    @Published var weight: String = ""
    @Published var age: String = ""
    @Published var gender: Int = 0
    @Published var activity: Int = 0
    @Published var objectives: Int = 0

    private let dataSource: SwiftDataManager
    private let math = MathManager()

    init(dataSource: SwiftDataManager) {
        self.dataSource = dataSource
    }

    func save() {
        let user = User(age: age.toFloat()!,
                        weight: weight.toFloat()!,
                        height: height.toFloat()!,
                        type: getObjective(),
                        activity: getActivity(),
                        gender: gender == 0 ? .male : .female
        )
        user.calories = math.getDailyCalories(user: user)
        user.proteins = math.getMacros(user: user).first(where: { $0.key == "proteins" })!.value
        user.carbs = math.getMacros(user: user).first(where: { $0.key == "carbs" })!.value
        user.fat = math.getMacros(user: user).first(where: { $0.key == "fat" })!.value
        dataSource.editUser(user)
    }

    func getActivity() -> ActivityType {
        switch activity {
            case 0:
                return .sedentary
            case 1:
                return .lowActivity
            case 2:
                return .highActivity
            case 3:
                return .insaneActivity
            default:
                return .lowActivity
        }
    }

    func getObjective() -> ObjectiveType {
        switch objectives {
            case 0:
                return .cut
            case 1:
                return .maintain
            case 2:
                return .bulk
            default:
                return .maintain
        }
    }
}
