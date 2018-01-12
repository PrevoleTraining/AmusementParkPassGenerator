//
//  Checkpoint.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 11.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

class Checkpoint<A: Accessable>: Checkpointable {
    var access: A
    
    init(access: A) {
        self.access = access
    }
    
    func swipe(pass: Passable) -> SwipeResult {
        return SwipeResult(status: .denied, message: "No access")
    }
}

