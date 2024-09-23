//
//  HealthKitManager.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 21/09/2024.
//

import Foundation
import HealthKit

class HealthKitManager: ObservableObject {
    private let healthStore = HKHealthStore()
    static let shared = HealthKitManager()
    @Published var stepCount: Float = 0.0

    init() {
        requestAuthorization()
    }

    private func requestAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit is not available on this device.")
            return
        }

        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

        healthStore.requestAuthorization(toShare: nil, read: [stepType]) { (success, error) in
            if !success {
                print("HealthKit authorization failed: \(String(describing: error))")
            }
        }
    }

    func getSteps(date: Date, completion: @escaping (Float) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

        let now = date
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: date.endOfDay(),
            options: .strictStartDate
        )

        let query = HKStatisticsQuery(
            quantityType: stepsQuantityType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(Float(sum.doubleValue(for: HKUnit.count())))
        }

        healthStore.execute(query)
    }
}
