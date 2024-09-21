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
    @Published var stepCount: Double = 0.0

    init() {
        requestAuthorization()
    }

    // Request authorization to access HealthKit data
    private func requestAuthorization() {
        // Check if HealthKit is available on the device
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit is not available on this device.")
            return
        }

        // Define the health data we want to read
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

        // Request permission to read the step count data
        healthStore.requestAuthorization(toShare: nil, read: [stepType]) { (success, error) in
            if !success {
                print("HealthKit authorization failed: \(String(describing: error))")
            } else {
                print("HealthKit authorization granted.")
                self.fetchStepCountData()
            }
        }
    }

    // Fetch step count data
    func fetchStepCountData() {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

        // Set the date range to fetch steps (e.g., today)
        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = Date()

        // Create a predicate to specify the date range
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        // Define a query to fetch step count samples
        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { [weak self] _, result, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching step count: \(error.localizedDescription)")
                return
            }

            if let result = result, let sum = result.sumQuantity() {
                let steps = sum.doubleValue(for: HKUnit.count())
                DispatchQueue.main.async {
                    self.stepCount = steps
                }
            } else {
                print("No step data found")
            }
        }

        // Execute the query
        healthStore.execute(query)
    }
}
