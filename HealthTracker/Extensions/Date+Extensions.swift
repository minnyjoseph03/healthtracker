//
//  Date+Extensions.swift
//  HealthTracker
//
//  Created by Minny Joseph on 16/12/24.
//

import Foundation

extension Date {
    func timeString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: self)
    }
    
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: Date())
    }
    
    static func getCurrentDateAndTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        return dateFormatter.string(from: Date())
    }
    
    static func getCurrentDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.string(from: Date())
    }
    
    func toStringChangeDate(format: String = "dd/MM/yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    static func dateFromDateString(str: String, dateFormat: String = "dd/MM/yyyy hh:mm a") -> Date? {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        //        formatter.locale = Locale(identifier: "en_US_POSIX")
        //        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = dateFormat
        return formatter.date(from: str)
    }
    
    func formatGetDayFullDateString(_ originalDateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        
        if let originalDate = dateFormatter.date(from: originalDateString) {
            
            let calendar = Calendar.current
            if calendar.isDateInToday(originalDate) {
                return "Today"
            } else {
                let outputDateFormatter = DateFormatter()
                outputDateFormatter.dateFormat = "dd/MM/yyyy"
                let formattedDate = outputDateFormatter.string(from: originalDate)
                return formattedDate
            }
        } else {
            return nil // Return nil in case of parsing failure
        }
    }
}

extension String {
    
    func isToday() -> Bool {
        // Create a DateFormatter to parse the date string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z" // Adjust the format as needed
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensure consistent parsing
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") // Parse as UTC

        // Convert the string to a Date
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            return calendar.isDateInToday(date) // Check if the date is today
        }
        return false
    }
    
    func isTodayOrYesterday() -> String? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = dateFormatter.date(from: self) else {
            return nil
        }

        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            return nil  // Date is neither today nor yesterday
        }
    }
    
    func toFormattedTime() -> String? {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoDateFormatter.date(from: self) else {
            return nil
        }
        
        let timeFormatter = DateFormatter()
//        timeFormatter.locale = Locale(identifier: "en_US_POSIX")
        timeFormatter.dateFormat = "hh:mm a"
        return timeFormatter.string(from: date)
    }
    
    func toFormattedDate() -> String? {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoDateFormatter.date(from: self) else {
            return nil
        }
        
        let timeFormatter = DateFormatter()
//        timeFormatter.locale = Locale(identifier: "en_US_POSIX")
        timeFormatter.dateFormat = "dd/MM/yyyy"
        return timeFormatter.string(from: date)
    }
}

extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
}
