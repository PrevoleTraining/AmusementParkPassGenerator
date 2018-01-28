//
//  Checkpointable.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 11.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import Foundation

/**
 * A check point is a terminal where a check of the access is performed. The
 * person with a pass scan it and see if he is granted the access or not.
 */
protocol Checkpointable {
    var name: String { get }
    
    /**
     * Check the access rights of a pass
     *
     * - parameter pass: The pass to verify
     *
     * - returns: The check access results
     */
    func swipe(pass: Passable) -> SwipeResult
}

extension Checkpointable {
    /**
     * In addition of the standard check, an aditional one is available
     * to check the accesses but also to manage the person birthday if
     * known.
     *
     * The birhtday check is only peformed when the access have been granted.
     *
     * - parameter pass: The pass to verify
     *
     * - returns: The check access results
     */
    func swipeWithBirthdayCheck(pass: Passable) -> SwipeResult {
        var result = swipe(pass: pass)
        
        switch result.status {
        case .granted, .grantedForDiscount:
            if let birthDate = pass.birthDate, Date().isBirthDate(date: birthDate) {
                result.birthDateMessage = true
            }
            return result
        default: return result
        }
    }
}
