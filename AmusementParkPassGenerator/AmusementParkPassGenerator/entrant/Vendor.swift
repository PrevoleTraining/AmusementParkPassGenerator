//
//  Vendor.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 22.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

class Vendor: AreaRestrictedEntrantable, Identifiable, Descriptable {
    var accesses: [AreaAccess]?
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func description() -> String {
        return "Name: \(name)"
    }
    
    func isEqual(rhs: Vendor) -> Bool {
        return name == rhs.name
    }
}
