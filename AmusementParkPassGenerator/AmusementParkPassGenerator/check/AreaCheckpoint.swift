//
//  AreaCheckpoint.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 11.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

/**
 * Area checkpoint terminal
 */
class AreaCheckpoint: Checkpoint<AreaAccess> {
    /**
     * Create an area checkpoint with an area access
     *
     * - parameter access: The area access of the terminal
     */
    override init(access: AreaAccess) {
        super.init(access: access)
    }
    
    override func swipe(pass: Passable) -> SwipeResult {
        if pass.hasAccess(access: access) {
            return SwipeResult(status: .granted)
        } else {
            return SwipeResult(status: .denied, message: "No access granted to \(access.description())")
        }
    }
}
