//
//  DiscountCheckpoint.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 11.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

class DiscountCheckpoint: Checkpoint<DiscountAccess> {
    func applyDiscount() {
        let discount = access.discount()
        print("\(discount)% on \(access) has been applied")
    }
}

