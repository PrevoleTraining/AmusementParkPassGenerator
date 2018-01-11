//
//  Personable.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 10.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

import Foundation

protocol Personable {
    var firstName: String? { get set }
    var lastName: String? { get set }
    var street: String? { get set }
    var city: String? { get set }
    var state: String? { get set }
    var zipCode: String? { get set }
    
    var birthDate: Date? { get set }
    
    var pass: Passable { get }
}
