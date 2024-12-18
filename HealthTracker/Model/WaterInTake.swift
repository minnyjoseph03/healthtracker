//
//  WaterInTake.swift
//  HealthTracker
//
//  Created by Minny Joseph on 16/12/24.
//

import Foundation

// MARK: - Model

struct WaterInTakeData {
    let id: UUID
    let value: Double
    let timestamp: Date
    var timeType: TimeOfDay {
        let hour = Calendar.current.component(.hour, from: timestamp)
        switch hour {
        case 6..<12: return .morning
        case 12..<17: return .afternoon
        case 17..<21: return .evening
        default: return .night
        }
    }
}

enum TimeOfDay: String, CaseIterable {
    case morning = "Morning"
    case afternoon = "Afternoon"
    case evening = "Evening"
    case night = "Night"
}
