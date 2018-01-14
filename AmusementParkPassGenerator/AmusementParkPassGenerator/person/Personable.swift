//
//  Personable.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 10.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

import Foundation

protocol Personable: CustomStringConvertible {
    var firstName: String? { get set }
    var lastName: String? { get set }
    var street: String? { get set }
    var city: String? { get set }
    var state: String? { get set }
    var zipCode: String? { get set }
    
    var birthDate: Date? { get set }
    
    var pass: Passable { get }
}

extension Personable {
    var description: String {
        var strBirthDate = "n/a"
        
        if let birthDate = birthDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            strBirthDate = formatter.string(from: birthDate)
        }
        
        return "firstName: \(firstName ?? "n/a"), lastName: \(lastName ?? "n/a"), street: \(street ?? "n/a"), city: \(city ?? "n/a"), \(zipCode ?? "n/a"), \(state ?? "n/a"), birthDate: \(strBirthDate)"
    }
}
