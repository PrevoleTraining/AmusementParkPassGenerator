//
//  Checkpoint.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 11.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

/**
 * A base implementation of a checkpoint for the theme park
 */
class Checkpoint<A: Accessable>: Checkpointable {
    var access: A
    
    /**
     * Create the checkpoint
     *
     * - parameter access: The access to check
     */
    init(access: A) {
        self.access = access
    }
    
    /**
     * By default, if this func is not overrided, it denies the access
     * to the checkpoint.
     *
     * - parameter pass: The pass to check
     *
     * - returns: The check result
     */
    func swipe(pass: Passable) -> SwipeResult {
        return SwipeResult(status: .denied, message: "No access")
    }
}

