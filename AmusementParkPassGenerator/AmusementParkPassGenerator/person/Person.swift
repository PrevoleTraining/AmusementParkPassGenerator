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
}
