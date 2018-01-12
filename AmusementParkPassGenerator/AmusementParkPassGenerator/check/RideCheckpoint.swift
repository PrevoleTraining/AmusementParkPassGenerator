//
//  RideCheckpoint.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 11.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

import Foundation

class RideCheckpoint: Checkpoint<RideAccess> {
    let antiCheatDelay: TimeInterval = -5
    
    var lastCheck: (pass: Passable, date: Date)?
    
    override init(access: RideAccess) {
        super.init(access: access)
    }
    
    override func swipe(pass: Passable) -> SwipeResult {
        let previousCheck = lastCheck
        lastCheck = (pass: pass, date: Date())
        
        if let previousCheck = previousCheck, previousCheck.pass.uuid == pass.uuid && previousCheck.date.timeIntervalSinceNow > antiCheatDelay {
            return SwipeResult(status: .denied, message: "Attempt ride access cheating")
        } else if pass.hasAccess(access: access) {
            return SwipeResult(status: .granted)
        } else {
            return SwipeResult(status: .denied, message: "No access to this ride")
        }
    }

}

