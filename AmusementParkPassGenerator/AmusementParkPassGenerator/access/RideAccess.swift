//
//  RideAccess.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 09.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

/**
 * Represent a ride access in the park. It does not include
 * the access to the ride control area which is handle in
 * the area accesses
 */
enum RideAccess: String, Accessable, Equatable {
    case allRides
    case skipRideLines
    
    func description() -> String {
        switch self {
        case .allRides: return "All rides"
        case .skipRideLines: return "Skip all ride lines"
        }
    }
    
    func isEqualTo(_ rhs: Accessable) -> Bool {
        guard let rideAccess = rhs as? RideAccess else {
            return false
        }
        
        return self == rideAccess
    }
}
