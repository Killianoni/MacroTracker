//
//  User.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 13/09/2024.
//

import Foundation
import SwiftData

enum ObjectiveType: Hashable, Codable {
    case bulk
    case cut
    case maintain
}

enum ActivityType: Hashable, Codable {
    case sedentary
    case lowActivity
    case highActivity
    case insaneActivity
}

enum Gender: String, Hashable, Codable, CaseIterable, Identifiable {
    case male
    case female
    var id: String { return self.rawValue }
}

@Model
final class User {
    @Attribute(.unique) var id: String
    var proteins: Float
    var fat: Float
    var carbs: Float
    var calories: Float
    var age: Float
    var weight: Float
    var height: Float
    var steps: Float
    var type: ObjectiveType
    var activity: ActivityType
    var gender: Gender

    init(id: String = UUID().uuidString, 
         proteins: Float = 150,
         fat: Float = 60, 
         carbs: Float = 200,
         calories: Float = 2000,
         age: Float = 20,
         weight: Float = 80,
         height: Float = 180,
         steps: Float = 10000,
         type: ObjectiveType = .maintain,
         activity: ActivityType = .lowActivity,
         gender: Gender = .male
    ) {

        self.id = id
        self.proteins = proteins
        self.fat = fat
        self.carbs = carbs
        self.calories = calories
        self.age = age
        self.weight = weight
        self.height = height
        self.steps = steps
        self.type = type
        self.activity = activity
        self.gender = gender
    }
}

