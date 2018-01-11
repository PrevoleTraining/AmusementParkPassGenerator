//
//  DiscountCheckpoint.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 11.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

class DiscountCheckpoint: Checkpoint<DiscountAccess> {
    override func swipe(pass: Passable) -> SwipeResult {
        if pass.hasAccess(access: access) {
            return .grantedForDiscount(discount: access.discount())
        } else {
            return .denied(reason: "No discount granted for \(access.description())")
        }
    }
}
