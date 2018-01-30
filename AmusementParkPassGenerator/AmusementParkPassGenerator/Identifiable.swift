//
//  Identifiable.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 22.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

/**
 * Make possible to retrieve an object by a semantic value
 */
protocol Identifiable {
    // The assosiated type
    associatedtype Identity
    
    /**
     * Check if object of the same type are the same
     * by checking their identifier
     *
     * - parameter rhs: The right hand sign
     *
     * - returns: True if both identifiers match
     */
    func isEqual(rhs: Identity) -> Bool
}
