//
//  DiscountCheckpoint.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 11.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

class DiscountCheckpoint: Checkpoint<DiscountAccess> {
    /**
     * Create an discount checkpoint with an discount access
     *
     * - parameter access: The discount access of the terminal
     */
   override init(access: DiscountAccess) {
        super.init(access: access)
    }
    
    override func swipe(pass: Passable) -> SwipeResult {
        // If access granted, retrieve the discount value to forward it
        if let accessFound = pass.findAccess(access: access) as? DiscountAccess {
            return SwipeResult(status: .grantedForDiscount(discount: accessFound))
        } else {
            return SwipeResult(status: .denied, message: access.description())
        }
    }
}
