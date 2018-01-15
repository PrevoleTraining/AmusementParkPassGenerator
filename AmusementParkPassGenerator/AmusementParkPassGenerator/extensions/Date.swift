//
//  Date.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 12.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import Foundation

/**
 * Represent a date with the day, month and year components
 */
struct DayMonthYear: Equatable {
    let day: Int
    let month: Int
    let year: Int
    
    /**
     * Extract the year, month and day to create the representation
     *
     * - returns: The day, month and year representation of the date
     */
    static func create(from date: Date) -> DayMonthYear {
        return DayMonthYear(
            day: Calendar.current.component(.day, from: date),
            month: Calendar.current.component(.month, from: date),
            year: Calendar.current.component(.year, from: date)
        )
    }
    
    /**
     * Equality between to day, month and year representations
     *
     * - parameters:
     *  - lhs: Left hand sign representation
     *  - rhs: Right hand sign representation
     *
     * - returns: True if day, month and year are equal
     */
    static func ==(lhs: DayMonthYear, rhs: DayMonthYear) -> Bool {
        return lhs.day == rhs.day && lhs.month == rhs.month && lhs.year == rhs.year
    }
}

extension Date {
    /**
     * Check if a date is equal to today.
     *
     * - parameter date: The date to compare with today date
     *
     * - returns: True if the today date is equal to the given date
     */
    func isToday(date: Date) -> Bool {
        return DayMonthYear.create(from: self) == DayMonthYear.create(from: date)
    }
    
    /**
     * Check if a two dates have a difference less than five years.
     *
     * - parameter date: The date to compare with
     *
     * - returns: True if two dates' difference is less than five years
     */
    func isLessThanFiveYearsFromNow(date: Date) -> Bool {
        return abs(DayMonthYear.create(from: date).year - DayMonthYear.create(from: self).year) < 5
    }
}
