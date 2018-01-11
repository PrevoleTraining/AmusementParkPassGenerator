//
//  AreaCheckpoint.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 11.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

class AreaCheckpoint: Checkpoint<AreaAccess> {
    override func swipe(pass: Passable) -> SwipeResult {
        if pass.hasAccess(access: access) {
            return SwipeResult(status: .granted)
        } else {
            return SwipeResult(status: .denied).add(message: "No access granted to \(access.description())")
        }
    }

}
