//
//  Accessable.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 09.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

/**
 * Represent an access right in the park
 */
protocol Accessable: Descriptable {
    /**
     * Check if an access is equal to another one
     *
     * - parameter rhs: Right hand sign access
     *
     * - returns: True if two accesses are equal
     */
    func isEqualTo(_ rhs: Accessable) -> Bool
}

