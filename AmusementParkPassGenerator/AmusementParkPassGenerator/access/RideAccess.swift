//
//  RideAccess.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 09.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
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
