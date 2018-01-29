//
//  PopulationInfoUnarchiver.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 27.01.18
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//
import Foundation
import os.log

/**
 * Converter of population loaded from a plist to the population collection
 */
class PopulationInfoUnarchiver {
    static let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "data")

    /**
     * Convert the array of population
     *
     * - parameter fromArray: Array of untyped vendors
     *
     * - return Collection of population info
     */
    static func population(fromArray array: [AnyObject]) throws -> PopulationInfoCollection {
        let population = PopulationInfoCollection()
        
        for (index, raw) in array.enumerated() {
            if let itemDictionary = raw as? [String: Any] {
                let categoryAndSubCategory = EntrantableUnarchiver.unarchiveCategeryAndSubCategory(itemDictionary: itemDictionary)

                let samplePerson = PopulationInfo(categoryAndSubCategory: categoryAndSubCategory)
                
                if let personalInfo = itemDictionary["personalInfo"] as? [String: Any] {
                    extract(itemDictionary: personalInfo, field: "visitDate", { samplePerson.visitDate = $0 })
                    extract(itemDictionary: personalInfo, field: "ssn", { samplePerson.ssn = $0 })
                    extract(itemDictionary: personalInfo, field: "project", { samplePerson.project = $0 })
                    extract(itemDictionary: personalInfo, field: "firstName", { samplePerson.firstName = $0 })
                    extract(itemDictionary: personalInfo, field: "lastName", { samplePerson.lastName = $0 })
                    extract(itemDictionary: personalInfo, field: "birthDate", { samplePerson.birthDate = $0 })
                    extract(itemDictionary: personalInfo, field: "vendor", { samplePerson.vendor = $0 })
                    extract(itemDictionary: personalInfo, field: "managementTier", { samplePerson.managementTier = $0 })
                    extract(itemDictionary: personalInfo, field: "street", { samplePerson.street = $0 })
                    extract(itemDictionary: personalInfo, field: "city", { samplePerson.city = $0 })
                    extract(itemDictionary: personalInfo, field: "state", { samplePerson.state = $0 })
                    extract(itemDictionary: personalInfo, field: "zip", { samplePerson.zipCode = $0 })
                    
                    if samplePerson.visitDate == "today()" {
                        samplePerson.visitDate = Date().defaultFormat()
                    }
                    
                    population.add(person: samplePerson)
                } else {
                    os_log("The sample person %@ has no default personal info", log: log, type: .info, "\(index)")
                }
            }
        }
        
        return population
    }
    
    /**
     * Extract the content of one field from the item dictionary
     *
     * - parameter itemDictionary: The item dictionary where to extract the data
     * - parameter field: The field to extract
     * - parameter extractor: The extractor to handle the retrieve data
     */
    static func extract(itemDictionary: [String: Any], field: String, _ extractor: (String?) -> Void) {
        if let value = itemDictionary[field] as? String {
            extractor(value)
        }
    }
}
