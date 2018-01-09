//
//  EntrantCategory.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 09.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

enum EntrantCategory: String {
    case guest = "Guest"
    case employee = "Employee"
    case manager = "Manager"
    
    func subCategories() -> [EntrantSubCategory] {
        switch self {
        case .guest: return [.child, .classic, .vip]
        case .employee: return [.hourlyFood, .hourlyRide, .hourlyMaintenance]
        case .manager: return []
        }
    }
}
