//
//  EntrantCategory.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 09.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

enum EntrantCategory: String, Descriptable {
    case guest
    case employee
    case manager
    
    func description() -> String {
        return "\(self)".capitalizingFirstLetter()
    }
    
    func subCategories() -> [EntrantSubCategory] {
        switch self {
        case .guest: return [.child, .classic, .vip]
        case .employee: return [.hourlyFood, .hourlyRide, .hourlyMaintenance]
        case .manager: return []
        }
    }
}
