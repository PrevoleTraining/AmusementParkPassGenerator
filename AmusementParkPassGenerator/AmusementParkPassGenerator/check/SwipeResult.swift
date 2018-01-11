//
//  SwipeResult.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 11.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

struct SwipeResult {
    var status: Status
    var messages: [String] = []
    
    init(status: Status) {
        self.status = status
    }
    
    mutating func add(message: String) -> SwipeResult {
        messages.append(message)
        return self
    }
    
    enum Status {
        case granted
        case grantedForDiscount(discount: Int)
        case denied
    }
}

