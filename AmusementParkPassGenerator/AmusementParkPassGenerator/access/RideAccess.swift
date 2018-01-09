//
//  RideAccess.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 09.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

enum RideAccess: String, Accessable {
    case allRides
    case skipRideLines
    
    func description() -> String {
        switch self {
        case .allRides: return "All rides"
        case .skipRideLines: return "Skip all ride lines"
        }
    }
}
