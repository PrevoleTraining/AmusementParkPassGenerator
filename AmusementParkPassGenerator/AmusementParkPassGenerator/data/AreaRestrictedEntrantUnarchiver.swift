//
//  EventCollectionUnarchiver.swift
//  BoutTime
//
//  Created by PrevoleTraining on 22.01.18
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//
import Foundation
import os.log

/**
 Converter of entrants loaded from a plist to the entrants collection
 */
class AreaRestrictedEntrantUnarchiver {
    static let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "data")
    
    /**
     * Convert the array of vendors not typed to the venors
     *
     * - parameter fromArray: Array of untyped vendors
     *
     * - return Collection of vendors
     */
    static func vendors(fromArray array: [AnyObject]) throws -> [Vendor] {
        var vendors: [Vendor] = []
        
        for (index, raw) in array.enumerated() {
            if let itemDictionary = raw as? [String: Any],
                let name = itemDictionary["vendor"] as? String {
                
                let vendor = Vendor(name: name)
                vendor.accesses = extractAccesses(from: itemDictionary)
                vendors.append(vendor)
            } else {
                os_log("Unable to load the vendor %@", log: log, type: .info, "\(index)")
            }
        }
        
        return vendors
    }

    /**
     * Convert the array of projects not typed to the projects
     *
     * - parameter fromArray: Array of untyped projects
     *
     * - return Collection of projects
     */
    static func projects(fromArray array: [AnyObject]) throws -> [Project] {
        var projects: [Project] = []
        
        for (index, raw) in array.enumerated() {
            if let itemDictionary = raw as? [String: Any],
                let number = itemDictionary["number"] as? String {
                
                let project = Project(number: number)
                project.accesses = extractAccesses(from: itemDictionary)
                projects.append(project)
            } else {
                os_log("Unable to load the project %@", log: log, type: .info, "\(index)")
            }
        }
        
        return projects
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
    static func extractAccesses(from itemDictionary: [String: Any]) -> [AreaAccess] {
        var accesses: [AreaAccess] = []
        
        if let rawAccesses = itemDictionary["AreaAccess"] as? [String] {
            for rawAccess in rawAccesses {
                if let access = AreaAccess(rawValue: rawAccess) {
                    accesses.append(access)
                } else {
                    os_log("Unable to find area access: %@", log: log, type: .error, rawAccess)
                }
            }
        }
        
        return accesses
    }
}
