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
    
    init(status: Status, message: String) {
        self.init(status: status)
        self.messages.append(message)
    }
    
    mutating func add(message: String) {
        messages.append(message)
    }
    
    enum Status {
        case granted
        case grantedForDiscount(discount: Int)
        case denied
    }
}

