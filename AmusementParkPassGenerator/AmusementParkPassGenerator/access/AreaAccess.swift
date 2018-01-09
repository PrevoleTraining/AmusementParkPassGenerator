//
//  AreaAccess.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 09.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

enum AreaAccess: String, Accessable {
    case amusement
    case kitchen
    case rideControl
    case maintenance
    case office
    
    func description() -> String {
        switch self {
        case .amusement: return "Amusement Areas"
        case .kitchen: return "Ktichen Areas"
        case .rideControl: return "Ride Control Areas"
        case .maintenance: return "Maintenance Areas"
        case .office: return "Office Areas"
        }
    }
}
