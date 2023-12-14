//
//  Item.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 14/12/2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
