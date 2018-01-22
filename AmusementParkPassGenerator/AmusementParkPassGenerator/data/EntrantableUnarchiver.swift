//
//  EventCollectionUnarchiver.swift
//  BoutTime
//
//  Created by PrevoleTraining on 15.12.17.
//  Updated by PrevoleTraining on 09.01.18
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//
import Foundation
import os.log

/**
 Converter of entrants loaded from a plist to the entrants collection
 */
class EntrantableUnarchiver {
    static let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "data")
    
    /**
     Convert the array of entrants not typed to the entrants
     
     - parameter fromArray: Array of untyped entrants
     
     - return Collection of entrants
     */
    static func entrants(fromArray array: [AnyObject]) throws -> [Entrantable] {
        var entrants: [Entrantable] = []
        
        for (index, raw) in array.enumerated() {
            if let itemDictionary = raw as? [String: Any],
                let rawCategory = itemDictionary["category"] as? String,
                let category = EntrantCategory(rawValue: rawCategory) {
                
                var entrant: Entrant
                
                if let rawSubCategory = itemDictionary["subCategory"] as? String,
                    let subCategory = EntrantSubCategory(rawValue: rawSubCategory) {
                    entrant = Entrant(category: category, subCategory: subCategory)
                } else {
                    entrant = Entrant(category: category)
                }
                
                var accesses: [Accessable] = []
                
                // Process the different accesses
                accesses.append(contentsOf: extractAccesses(of: .area, from: itemDictionary))
                accesses.append(contentsOf: extractAccesses(of: .ride, from: itemDictionary))
                accesses.append(contentsOf: extractDiscountAccesses(from: itemDictionary))

                entrant.accesses = accesses
                
                entrant.personalInfo = extractPersonalInfo(from: itemDictionary)
                
                entrants.append(entrant)
            } else {
                os_log("Unable to load the entrant %@", log: log, type: .info, "\(index)")
            }
        }
        
        return entrants
    }

    /**
     * Extract the accesses for an access category
     *
     * - parameters:
     *  - of: The type of access to extract
     *  - from: The dictionary where to find the accesses
     *
     * returns: The accesses extracted
     */
    static func extractAccesses(of type: AccessType, from itemDictionary: [String: Any]) -> [Accessable] {
        var accesses: [Accessable] = []
        
        if let rawAccesses = itemDictionary["\(type)Access"] as? [String] {
            for rawAccess in rawAccesses {
                if let access = type.build(rawValue: rawAccess) {
                    accesses.append(access)
                } else {
                    os_log("Unable to find %@ access: %@", log: log, type: .error, "\(type)", rawAccess)
                }
            }
        }
        
        return accesses
    }

    /**
     * Extract the discount accesses. These accesses are a bit different as they
     * contain the discount value to grant.
     *
     * - parameters:
     *  - from: The item dictionary that contains the accesses
     *
     * - returns: The array of accesses extracted
     */
    static func extractDiscountAccesses(from itemDictionary: [String: Any]) -> [Accessable] {
        var accesses: [Accessable] = []
        
        if let rawDiscountAccesses = itemDictionary["discountAccess"] as? [String: Int] {
            for rawDiscountAccess in rawDiscountAccesses {
                if let access = AccessType.discount.build(rawValue: rawDiscountAccess.key, value: rawDiscountAccess.value) {
                    accesses.append(access)
                } else {
                    os_log("Unable to find discount access: %@", log: log, type: .error, "\(rawDiscountAccess)")
                }
            }
        }
        
        return accesses
    }

    /**
     * Extract the list of personal info required for the access profile
     *
     * - parameters:
     *  - from: The item dictionary where to find the personal info fields
     *
     * - returns: The array of personal info fields required by the access profile
     */
    static func extractPersonalInfo(from itemDictionary: [String: Any]) -> [PersonalInfo] {
        var personalInfo: [PersonalInfo] = []
        
        if let rawPersonalInfo = itemDictionary["personalInfo"] as? [String] {
            for rawSinglePersonalInfo in rawPersonalInfo {
                if let singlePersonalInfo = PersonalInfo(rawValue: rawSinglePersonalInfo) {
                    personalInfo.append(singlePersonalInfo)
                } else {
                    os_log("Unable to find personal info: %@", log: log, type: .error, "\(rawSinglePersonalInfo)")
                }
            }
        }
        
        return personalInfo
    }
}

/**
 * Access type acts as a factory
 */
enum AccessType {
    case area
    case ride
    case discount
    
    /**
     * Build an access object of the right type according to the type of the
     * rights extracted.
     *
     * - parameters:
     *  - rawValue: The raw value to build the access object
     *  - value: The discount for the discount access
     */
    func build(rawValue: String, value: Int = 0) -> Accessable? {
        switch self {
        case .area: return AreaAccess(rawValue: rawValue)
        case .ride: return RideAccess(rawValue: rawValue)
        case .discount:
            do {
                return try DiscountAccess.discount(name: rawValue, discount: value)
            } catch DiscountAccessError.noSuchDiscountType {
                fatalError("Unable to find the discount \(rawValue)")
            } catch let unknownError {
                fatalError(unknownError.localizedDescription)
            }
        }
    }
}
