//
//  Date.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 12.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

import Foundation

struct DayMonthYear: Equatable {
    let day: Int
    let month: Int
    let year: Int
    
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
}

extension Date {
    func isToday(date: Date) -> Bool {
        return DayMonthYear.create(from: self) == DayMonthYear.create(from: date)
    }
    
    func isLessThanFiveYearsFromNow(date: Date) -> Bool {
        return abs(DayMonthYear.create(from: date).year - DayMonthYear.create(from: self).year) < 5
    }
}
