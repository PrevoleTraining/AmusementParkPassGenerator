//
//  PersonalInfo.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 10.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import Foundation

let juniorAgeThreshold = 5
let seniorAgeThreshold = 65
let minAcceptableAge = 2
let maxAcceptableAge = 100

/**
 * The different personal info that can be required for a person
 *
 * For example: Free child guests are required to provide their birth date
 */
enum PersonalInfo: String, Descriptable {
    case birthDateJunior
    case birthDate
    case birthDateSenior
    case firstName
    case lastName
    case vendor
    case street
    case city
    case state
    case zip
    case ssn
    case project
    case managementTier
    case visitDate
    
    func description() -> String {
        switch self {
        case .birthDateJunior: return "Date of Birth (must be under 5 years old)"
        case .birthDate: return "Date of Birth"
        case .birthDateSenior: return "Date of Birth (must be over 64 years old)"
        case .firstName: return "First Name"
        case .lastName: return "Last Name"
        case .street: return "Street Address"
        case .zip: return "Zip Code"
        case .managementTier: return "Management Tier"
        case .visitDate: return "Date of Visit"
        case .ssn: return "Social Security Number"
        case .city, .state, .vendor, .project: return "\(self)".capitalizingFirstLetter()
        }
    }
    
    /**
     * Retrieve the validators for a specific personal info
     *
     * - parameter person: A person
     * - parameter projects: A collection of projects
     * - parameter
     */
    func validators(person: Personable) -> [() -> PersonalInfoError?] {
        switch self {
        case .birthDateJunior: return [ juniorBirthDateValidatorFactory(date: person.birthDate) ]
        case .birthDateSenior: return [ seniorBirthDateValidatorFactory(date: person.birthDate) ]
        case .birthDate: return [ birthDateValidatorFactory(date: person.birthDate) ]
        case .firstName: return stringValidatorFactory(with: person.firstName, min: 3, max: 10)
        case .lastName: return stringValidatorFactory(with: person.lastName, min: 3, max: 10)
        case .street: return stringValidatorFactory(with: person.street, min: 3, max: 20)
        case .city: return stringValidatorFactory(with: person.city, min: 3, max: 10)
        case .state: return stringValidatorFactory(with: person.state, min: 2, max: 2)
        case .zip: return [ isBlankValidatorFactory(str: person.zipCode), zipCodeValidatorFactory(zip: person.zipCode) ]
        case .ssn: return [ isBlankValidatorFactory(str: person.ssn), ssnValidatorFactory(ssn: person.ssn) ]
        case .project: return [ presenceValidatorFactory(field: person.project, error: .projectError) ]
        case .vendor: return [ presenceValidatorFactory(field: person.vendor, error: .vendorError) ]
        case .managementTier: return [ presenceValidatorFactory(field: person.managementTier, error: .managementTierError) ]
        case .visitDate: return [ visitDateValidatorFactory(date: person.visitDate) ]
        }
    }
}

/**
 * Junior birth date validator factory
 *
 * - parameter date: Birth date
 *
 * - returns: Closure acts as validator
 */
func juniorBirthDateValidatorFactory(date: Date?) -> () -> PersonalInfoError? {
    return { () -> PersonalInfoError? in
        guard let birthDate = date else {
            return .invalidJuniorBirthDate
        }
    
        if birthDate.isGreaterThanYearsFromNow(date: Date(), threshold: juniorAgeThreshold) {
            return .invalidJuniorBirthDate
        } else {
            return nil
        }
    }
}

/**
 * Senior birth date validator factory
 *
 * - parameter date: Birth date
 *
 * - returns: Closure acts as validator
 */
func seniorBirthDateValidatorFactory(date: Date?) -> () -> PersonalInfoError? {
    return { () -> PersonalInfoError? in
        guard let birthDate = date else {
            return .invalidSeniorBirthDate
        }
        
        if birthDate.isLessThanYearsFromNow(date: Date(), threshold: seniorAgeThreshold) {
            return .invalidSeniorBirthDate
        } else {
            return nil
        }
    }
}

/**
 * Birth date validator factory. Check if the birth date is reasonable
 *
 * - parameter date: Birth date
 *
 * - returns: Closure acts as validator
 */
func birthDateValidatorFactory(date: Date?) -> () -> PersonalInfoError? {
    return { () -> PersonalInfoError? in
        guard let birthDate = date else {
            return .invalidBirthDate
        }
        
        if !birthDate.isReasonableDateFromNow(date: Date(), min: minAcceptableAge, max: maxAcceptableAge) {
            return .invalidBirthDate
        } else {
            return nil
        }
    }
}

/**
 * Visit date validator factory. Check if the birth date is in the future
 *
 * - parameter date: Visit date
 *
 * - returns: Closure acts as validator
 */
func visitDateValidatorFactory(date: Date?) -> () -> PersonalInfoError? {
    return { () -> PersonalInfoError? in
        guard let visitDate = date else {
            return .invalidVisitDate
        }
        
        if visitDate.isInFutureFrom(date: Date()) {
            return .invalidVisitDate
        } else {
            return nil
        }
    }
}

/**
 * Blank validator factory
 *
 * - parameter str: String to validate
 *
 * - returns: Closure acts as validator
 */
func isBlankValidatorFactory(str: String?) -> () -> PersonalInfoError? {
    return { () -> PersonalInfoError? in
        guard let str = str else {
            return .blankError
        }
            
        return str.isEmpty ? .blankError : nil
    }
}

/**
 * Length range validator factory
 *
 * - parameter with: String to validate
 * - parameter min: The minimum length
 * - parameter max: The maximum length
 *
 * - returns: Closure acts as validator
 */
func lengthRangeValidatorFactory(with str: String?, min: Int, max: Int) -> () -> PersonalInfoError? {
    return { () -> PersonalInfoError? in
        guard let str = str else {
            return .lengthError(min: min, max: max)
        }
        
        if str.count < min || str.count > max {
            return .lengthError(min: min, max: max)
        } else {
            return nil
        }
    }
}

/**
 * ZIP Code validator factory
 *
 * - parameter zip: ZIP Code
 *
 * - returns: Closure acts as validator
 */
func zipCodeValidatorFactory(zip: String?) -> () -> PersonalInfoError? {
    return { () -> PersonalInfoError? in
        guard let zip = zip else {
            return .zipCodeError
        }
        
        if !zip.isInt || zip.count != 5 {
            return .zipCodeError
        } else {
            return nil
        }
    }
}

/**
 * Social Security Number validator factory
 *
 * - parameter ssn: Social Security Number
 *
 * - returns: Closure acts as validator
 */
func ssnValidatorFactory(ssn: String?) -> () -> PersonalInfoError? {
    return { () -> PersonalInfoError? in
        guard let ssn = ssn else {
            return .ssnError
        }
        
        if ssn.count != 11 && ssn.match(pattern: "([1-9][0-9][0-9]-){2}[1-9][0-9][0-9]") {
            return .ssnError
        } else {
            return nil
        }
    }
}

/**
 * Presence validator tier
 *
 * - parameter field: Field
 *
 * - returns: Closure acts as validator
 */
func presenceValidatorFactory<T>(field: T?, error: PersonalInfoError) -> () -> PersonalInfoError? {
    return { () -> PersonalInfoError? in
        guard let _ = field else {
            return error
        }
    
        return nil
    }
}

/**
 * Consolidated factor to build string common validators
 *
 * - parameter: String to validate
 * - parameter: Minimum length
 * - parameter: Maximum length
 *
 * returns: Array of closures acting as validators
 */
func stringValidatorFactory(with str: String?, min: Int, max: Int) -> [() -> PersonalInfoError?] {
    return [
        isBlankValidatorFactory(str: str),
        lengthRangeValidatorFactory(with: str, min: min, max: max)
    ]
}

/**
 * Personal info validation errors
 */
enum PersonalInfoError: Error, Descriptable, Equatable {
    case blankError
    case lengthError(min: Int, max: Int)
    case zipCodeError
    case ssnError
    case managementTierError
    case projectError
    case vendorError
    case invalidJuniorBirthDate
    case invalidSeniorBirthDate
    case invalidBirthDate
    case invalidVisitDate
    
    func description() -> String {
        switch self {
        case .blankError: return "Cannot be blank"
        case .lengthError(let min, let max):
            if min == max {
                return "Must be \(min) caracters lenght"
            } else {
                return "Must be between \(min) and \(max) caracters (inclusives)"
            }
        case .zipCodeError: return "The ZIP code must contain 5 digits"
        case .ssnError: return "The Social Security Number must follow the format 123-123-123 (each group of digits between 100 and 999)"
        case .managementTierError: return "The management tier must be present or is not valid"
        case .vendorError: return "The vendor must be present"
        case .projectError: return "The project must be present"
        case .invalidJuniorBirthDate: return "The birth date must be younger than \(juniorAgeThreshold + 1) years old"
        case .invalidSeniorBirthDate: return "The birth date must be older than \(seniorAgeThreshold - 1) years old"
        case .invalidBirthDate: return "The birth date must be in a reasonable range: \(minAcceptableAge) to \(maxAcceptableAge) years old (park safety)"
        case .invalidVisitDate: return "The date must be in the future"
        }
    }
    
    static func ==(lhs: PersonalInfoError, rhs: PersonalInfoError) -> Bool {
        switch (lhs, rhs) {
        case (.blankError, .blankError),
             (.lengthError, .lengthError),
             (.zipCodeError, .zipCodeError),
             (.ssnError, .ssnError),
             (.managementTierError, .managementTierError),
             (.projectError, .projectError),
             (.vendorError, .vendorError),
             (.invalidSeniorBirthDate, .invalidSeniorBirthDate),
             (.invalidJuniorBirthDate, .invalidJuniorBirthDate),
             (.invalidBirthDate, .invalidBirthDate),
             (.invalidVisitDate, .invalidVisitDate): return true
        default: return false
        }
    }
}

extension PersonalInfo {
    /**
     * Validate all the collection of personal info of a person
     *
     * - parameters:
     *  - person: The person to validate
     *  - personalInfo: The personal info collection to validate
     *
     * - returns: Collection of validation errors, empty collection if no error
     */
    static func validate(person: Personable, personalInfo: [PersonalInfo]) -> [PersonalInfo: [PersonalInfoError]] {
        var errors: [PersonalInfo: [PersonalInfoError]] = [:]
        
        for info in personalInfo {
            var currentErrors: [PersonalInfoError] = []
            
            for validator in info.validators(person: person) {
                let error = validator()
                if let error = error {
                    currentErrors.append(error)
                }
            }
            
            if !currentErrors.isEmpty {
                errors[info] = currentErrors
            }
        }
        
        return errors
    }
}
