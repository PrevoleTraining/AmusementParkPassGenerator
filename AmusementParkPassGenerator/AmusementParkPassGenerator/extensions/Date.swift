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
struct DayMonthYear: Equatable, Comparable {
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
    
    static func ==(lhs: DayMonthYear, rhs: DayMonthYear) -> Bool {
        return lhs.day == rhs.day && lhs.month == rhs.month && lhs.year == rhs.year
    }
    
    static func <(lhs: DayMonthYear, rhs: DayMonthYear) -> Bool {
        return lhs.year < rhs.year
            || (lhs.year == rhs.year && lhs.month < rhs.month)
            || (lhs.year == rhs.year && lhs.month == rhs.month && lhs.day < rhs.day)
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
     * - parameter threshold: The number of years to check
     *
     * - returns: True if two dates' difference is less than five years
     */
    func isLessThanYearsFromNow(date: Date, threshold: Int) -> Bool {
        return abs(DayMonthYear.create(from: date).year - DayMonthYear.create(from: self).year) < threshold
    }

    /**
     * Check if a two dates have a difference over than sixty four years.
     *
     * - parameter date: The date to compare with
     * - parameter threshold: The number of years to check
     *
     * - returns: True if two dates' difference is less than sixyty four years
     */
    func isGreaterThanYearsFromNow(date: Date, threshold: Int) -> Bool {
        return abs(DayMonthYear.create(from: date).year - DayMonthYear.create(from: self).year) > threshold
    }
    
    /**
     * Check if a two dates have a difference that is reasonable for an age.
     *
     * - parameter date: The date to compare with
     * - parameter min: The minimum acceptable years
     * - parameter max: The maximum acceptable years
     *
     * - returns: True if two dates' difference is reasonable
     */
    func isReasonableDateFromNow(date: Date, min: Int, max: Int) -> Bool {
        let difference = abs(DayMonthYear.create(from: date).year - DayMonthYear.create(from: self).year)
        return difference >= min && difference <= max
    }
    
    /**
     * Check if the given date is earlier than self
     *
     * - parameter date: The date to be in the past from the current date
     *
     * - returns: True if the current date is in the future
     */
    func isInFutureFrom(date: Date) -> Bool {
        return DayMonthYear.create(from: date) < DayMonthYear.create(from: self)
    }
    
    /**
     * Format a date with a default format: yyyy/MM/dd
     *
     * - returns: The formatted date as string
     */
    func defaultFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: self)
    }
}
