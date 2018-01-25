//
//  Person.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 10.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import Foundation

/**
 * Implementation of Personable
 */
class Person: Personable {
    var firstName: String?
    var lastName: String?
    var street: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var ssn: String?

    var managementTier: ManagementTier?

    var birthDate: Date?
    var visitDate: Date?
    
    var project: Project?
    var vendor: Vendor?
    
    var pass: Passable
    
    /**
     * Constructor
     *
     * - parameter pass: The pass given to the person
     */
    init(pass: Passable) {
        self.pass = pass
    }
    
    /**
     * Constructor
     *
     * - parameters:
     *  - pass: The pass given to the person
     *  - firstName: First name
     *  - lastName: Last name
     *  - street: Street
     *  - city: City
     *  - state: State
     *  - zipCode: ZIP Code
     *  - birthDate: Birth date
     */
    convenience init(pass: Passable, firstName: String, lastName: String, street: String, city: String, state: String, zipCode: String, birthDate: Date?, ssn: String?, managementTier: ManagementTier?, visitDate: Date?, project: Project?, vendor: Vendor?) {
        self.init(pass: pass)
        self.firstName = firstName
        self.lastName = lastName
        self.street = street
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.birthDate = birthDate
        self.ssn = ssn
        self.managementTier = managementTier
        self.visitDate = visitDate
        self.project = project
        self.vendor = vendor
    }
}
