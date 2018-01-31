//
//  Descriptable.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 10.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

/**
 * Similar to CustomStringConvertible without the
 * official purpose to represent a whole object to
 * be printed like with print()
 */
protocol Descriptable {
    /**
     * Retrieve a description
     *
     * - returns: The description
     */
    func description() -> String
}
