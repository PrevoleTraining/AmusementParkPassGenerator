//
//  Personable.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 10.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import Foundation

/**
 * A person is identified by his personal data that
 * are required depending the entrant category and sub category
 */
protocol Personable: CustomStringConvertible {
    var firstName: String? { get set }
    var lastName: String? { get set }
    var street: String? { get set }
    var city: String? { get set }
    var state: String? { get set }
    var zipCode: String? { get set }
    var ssn: String? { get set }
    var managementTier: ManagementTier? { get set }
    
    var project: Any? { get set }
    var vendor: Any? { get set }
    
    var birthDate: Date? { get set }
    var visitDate: Date? { get set }
    
    var pass: Passable { get }
}

extension Personable {
    var description: String {
        return "firstName: \(firstName ?? "n/a"), lastName: \(lastName ?? "n/a"), street: \(street ?? "n/a"), city: \(city ?? "n/a"), \(zipCode ?? "n/a"), \(state ?? "n/a"), birthDate: \(birthDate?.defaultFormat() ?? "n/a"), ssn: \(ssn ?? "n/a"), managementTier: \(managementTier?.rawValue ?? "n/a"), visitDate: \(visitDate?.defaultFormat() ?? "n/a")"
    }
}
