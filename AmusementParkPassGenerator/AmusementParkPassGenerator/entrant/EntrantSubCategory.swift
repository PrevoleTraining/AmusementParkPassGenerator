//
//  EntrantSubCategory.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 09.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

enum EntrantSubCategory: String, Descriptable {
    case child
    case classic
    case vip
    case hourlyFood
    case hourlyRide
    case hourlyMaintenance
    
    func description() -> String {
        switch self {
        case .child: return "Free Child"
        case .classic: return "Classic"
        case .vip: return "VIP"
        case .hourlyFood: return "Hourly Employee - Food Services"
        case .hourlyRide: return "Hourly Employee - Ride Services"
        case .hourlyMaintenance: return "Hourly Employee - Maintenance"
        }
    }
}
