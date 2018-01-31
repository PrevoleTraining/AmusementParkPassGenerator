//
//  RideCheckpoint.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 11.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import Foundation

class RideCheckpoint: Checkpoint<RideAccess> {
    let antiCheatDelay: TimeInterval = -5
    
    /**
     * To store the previous pass check with the date to enable the throtling mechanism
     */
    var lastCheck: (pass: Passable, date: Date)?
    
    /**
     * Create an ride checkpoint with an ride access
     *
     * - parameter name: Checkpoint name
     * - parameter access: The ride access of the terminal
     */
    override init(name: String, access: RideAccess) {
        super.init(name: name, access: access)
    }
    
    /**
     * Check the ride access. In addition, there is a check to forbid the
     * access to the ride if the same pass is checked within five seconds
     * to the same checkpoint.
     *
     * - parameter pass: The pass to check
     *
     * - returns: The check result
     */
    override func swipe(pass: Passable) -> SwipeResult {
        let previousCheck = lastCheck
        lastCheck = (pass: pass, date: Date())
        
        if let previousCheck = previousCheck, previousCheck.pass.uuid == pass.uuid && previousCheck.date.timeIntervalSinceNow > antiCheatDelay {
            return SwipeResult(status: .denied, message: "Attempt ride access cheating", tooFast: true)
        } else if pass.hasAccess(access: access) {
            return SwipeResult(status: .granted)
        } else {
            return SwipeResult(status: .denied, message: "No access to this ride")
        }
    }
}
