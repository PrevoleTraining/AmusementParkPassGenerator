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
class Person: PersonBase, Personable {
    var managementTier: ManagementTier?
    
    var birthDate: Date? {
        didSet {
            // Update the birth date on the pass
            pass.birthDate = birthDate
        }
    }
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
     * - pass: The pass given to the person
     * - firstName: First name
     * - lastName: Last name
     * - street: Street
     * - city: City
     * - state: State
     * - zipCode: ZIP Code
     * - birthDate: Birth date
     * - ssn: Social security number
     * - managementTier: Management tier
     * - visitDate: The date of visit
     * - project: Project
     * - vendor: Vendor
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
