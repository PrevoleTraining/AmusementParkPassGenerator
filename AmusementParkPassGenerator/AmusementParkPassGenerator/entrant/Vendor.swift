//
//  Vendor.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 22.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

/**
 * Represent a vendor in the park
 */
class Vendor: AreaRestrictedEntrantable, Identifiable, Descriptable {
    var accesses: [AreaAccess]?
    
    let name: String
    
    /**
     * Constructor
     *
     * - parameter name: The vendor's name
     */
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
