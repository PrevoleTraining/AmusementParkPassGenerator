//
//  AreaCheckpoint.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 11.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

class AreaCheckpoint: Checkpoint<AreaAccess> {
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
