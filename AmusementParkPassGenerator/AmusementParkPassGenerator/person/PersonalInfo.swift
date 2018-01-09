//
//  PersonalInfo.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 10.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

enum PersonalInfo: String, Descriptable {
    case dateOfBirthUnderFive
    case firstName
    case lastName
    case street
    case city
    case state
    case zip
    
    func description() -> String {
        switch self {
        case .dateOfBirthUnderFive: return "Date of Birth (must be under 5 years old)"
        case .firstName: return "First Name"
        case .lastName: return "Last Name"
        case .street: return "Street Address"
        case .zip: return "Zip Code"
        case .city, .state: return "\(self)".capitalizingFirstLetter()
        }
    }
}
