//
//  DiscountCheckpoint.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 11.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

class DiscountCheckpoint: Checkpoint<DiscountAccess> {
    override init(access: DiscountAccess) {
        super.init(access: access)
    }
    
    override func swipe(pass: Passable) -> SwipeResult {
        if let accessFound = pass.findAccess(access: access) as? DiscountAccess {
            return SwipeResult(status: .grantedForDiscount(discount: accessFound))
        } else {
            return SwipeResult(status: .denied, message: access.description())
        }
    }
}
