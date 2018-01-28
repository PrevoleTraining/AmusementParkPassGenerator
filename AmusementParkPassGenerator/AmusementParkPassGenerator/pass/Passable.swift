//
//  Passable.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 11.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import Foundation

/**
 * A pass is a card given to a person to go through the theme park
 * check points. It authorizes or denies the access to the
 * different areas and so on.
 */
protocol Passable {
    var uuid: UUID { get }
    var accesses: [Accessable] { get }
    
    var category: EntrantCategory { get }
    var subCategory: EntrantSubCategory? { get }

    var birthDate: Date? { get set }
   
    /**
     * Check if a pass gives the right to a certain area, ride
     * or discount.
     *
     * - parameter access: The access to check
     *
     * - returns: True if access has been granted on the pass
     */
    func hasAccess(access: Accessable) -> Bool
    
    /**
     * Retrieve the access
     *
     * - parameter access: The access to find
     *
     * - returns: The access found or nil if not
     */
    func findAccess(access: Accessable) -> Accessable?
}

