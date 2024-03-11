//
//  Date+Helpers.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 20/12/2023.
//

import Foundation

extension Date {
    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "dd MMMM yyyy"
        
        if Calendar.current.isDateInToday(self) {
            return "Today"
        } else {
            return formatter.string(from: self)
        }
    }
    
    func increment(by value: Int, component: Calendar.Component) -> Date? {
        return Calendar.current.date(byAdding: component, value: value, to: self)
    }
    
    func decrement(by value: Int, component: Calendar.Component) -> Date? {
        return Calendar.current.date(byAdding: component, value: -value, to: self)
    }
}
