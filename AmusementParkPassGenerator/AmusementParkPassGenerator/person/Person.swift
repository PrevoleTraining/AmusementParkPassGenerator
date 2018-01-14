//
//  Person.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 10.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

import Foundation

class Person: Personable {
    var firstName: String?
    var lastName: String?
    var street: String?
    var city: String?
    var state: String?
    var zipCode: String?
    
    var birthDate: Date?
    
    var pass: Passable
    
    init(pass: Passable) {
        self.pass = pass
    }
    
    convenience init(pass: Passable, firstName: String, lastName: String, street: String, city: String, state: String, zipCode: String, birthDate: Date?) {
        self.init(pass: pass)
        self.firstName = firstName
        self.lastName = lastName
        self.street = street
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.birthDate = birthDate
    }
}
