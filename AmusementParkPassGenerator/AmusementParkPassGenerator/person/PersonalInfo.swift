//
//  PersonalInfo.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 10.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import Foundation

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
    
    func isValid(person: Personable) -> PersonalInfoError? {
        func isBlank(str: String?, error: PersonalInfoError) -> PersonalInfoError? {
            guard let str = str else {
                return error
            }
            
            return str.isEmpty ? error : nil
        }
        
        switch self {
        case .dateOfBirthUnderFive:
            guard let birthDate = person.birthDate else {
                return .invalidBirthDateUnderFiveYears
            }
            
            if !birthDate.isLessThanFiveYearsFromNow(date: Date()) {
                return .invalidBirthDateUnderFiveYears
            } else {
                return nil
            }
        case .firstName: return isBlank(str: person.firstName, error: .invalidFirstName)
        case .lastName: return isBlank(str: person.lastName, error: .invalidLastName)
        case .street: return isBlank(str: person.street, error: .invalidStreet)
        case .city: return isBlank(str: person.city, error: .invalidCity)
        case .state: return isBlank(str: person.state, error: .invalidState)
        case .zip: return isBlank(str: person.zipCode, error: .invalidZip)
        }
    }
}

enum PersonalInfoError: Error, Descriptable {
    case invalidBirthDateUnderFiveYears
    case invalidFirstName
    case invalidLastName
    case invalidStreet
    case invalidCity
    case invalidState
    case invalidZip
    
    func description() -> String {
        switch self {
        case .invalidBirthDateUnderFiveYears: return "The birth date must be younger than five years old"
        case .invalidFirstName: return "First name is mandatory"
        case .invalidLastName: return "Last name is mandatory"
        case .invalidStreet, .invalidCity, .invalidState: return "\("\(self)".capitalizingFirstLetter()) is mandatory"
        case .invalidZip: return "Zip code is mandatory"
        }
    }
}

extension PersonalInfo {
    static func validate(person: Personable, personalInfo: [PersonalInfo]) -> [PersonalInfoError] {
        var errors: [PersonalInfoError] = []
        
        for info in personalInfo {
            if let error = info.isValid(person: person) {
                errors.append(error)
            }
        }
        
        return errors
    }
}
