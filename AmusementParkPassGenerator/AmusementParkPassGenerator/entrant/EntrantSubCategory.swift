//
//  EntrantSubCategory.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 09.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

/**
 * Sub categories of access profiles
 */
enum EntrantSubCategory: String, Descriptable {
    case child
    case classic
    case vip
    case senior
    case season
    case hourlyFood
    case hourlyRide
    case hourlyMaintenance
    case manager
    case contract
    
    func description() -> String {
        switch self {
        case .child: return "Free Child"
        case .vip: return "VIP"
        case .hourlyFood: return "Hourly Employee - Food Services"
        case .hourlyRide: return "Hourly Employee - Ride Services"
        case .hourlyMaintenance: return "Hourly Employee - Maintenance"
        case .manager, .classic, .senior, .season, .contract: return "\(self)".capitalizingFirstLetter()
        }
    }
}
