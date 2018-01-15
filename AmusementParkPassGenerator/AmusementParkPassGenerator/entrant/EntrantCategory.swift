//
//  EntrantCategory.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 09.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

/**
 * Main categories of entrant
 */
enum EntrantCategory: String, Descriptable {
    case guest
    case employee
    case vendor
    
    func description() -> String {
        return "\(self)".capitalizingFirstLetter()
    }
    
    /**
     * Retrieve the collection of sub categories for a given category
     *
     * - returns: The array of sub categories
     */
    func subCategories() -> [EntrantSubCategory] {
        switch self {
        case .guest: return [.child, .classic, .vip]
        case .employee: return [.hourlyFood, .hourlyRide, .hourlyMaintenance, .manager]
        case .vendor: return []
        }
    }
}
