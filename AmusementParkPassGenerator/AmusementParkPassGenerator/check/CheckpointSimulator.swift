//
//  CheckpointSimulator.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 28.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

/**
 * The checkpoint simulator helps to validate the passes.
 */
class CheckpointSimulator {
    /// Collection of simulator checkpoints for areas
    let areaCheckpoints: [Checkpointable] = [
        AreaCheckpoint(name: "Amusement test zone", access: .amusement),
        AreaCheckpoint(name: "Kitchen test zone", access: .kitchen),
        AreaCheckpoint(name: "Ride control test zone", access: .rideControl),
        AreaCheckpoint(name: "Maintenance test zone", access: .maintenance),
        AreaCheckpoint(name: "Office test zone", access: .office)
    ]
    
    /// Collection of simulator checkpoints for rides
    let rideCheckpoints: [Checkpointable]  = [
        RideCheckpoint(name: "RollerCoaster test ride", access: .allRides),
        RideCheckpoint(name: "RollerCoaster fast lane test ride", access: .skipRideLines)
    ]
    
    /// Collection of simulator checkpoint for discounts
    let discountCheckpoints: [Checkpointable]  = [
        DiscountCheckpoint(name: "Burgers test shop", access: .food(discount: 0)),
        DiscountCheckpoint(name: "Souvenirs test shop", access: .merchandise(discount: 0))
    ]
    
    /**
     * Test the pass against the different area simulators
     *
     * - parameter pass: The pass to test
     *
     * - returns: The swipe result
     */
    func testAreaCheckpoints(pass: Passable) -> [String: SwipeResult]{
        return testCheckpoints(pass: pass, checkpoints: areaCheckpoints)
    }
    
    /**
     * Test the pass against the different ride simulators
     *
     * - parameter pass: The pass to test
     *
     * - returns: The swipe result
     */
    func testRideCheckpoints(pass: Passable) -> [String: SwipeResult]{
        return testCheckpoints(pass: pass, checkpoints: rideCheckpoints)
    }

    /**
     * Test the pass against the different discount simulators
     *
     * - parameter pass: The pass to test
     *
     * - returns: The swipe result
     */
    func testDiscountCheckpoints(pass: Passable) -> [String: SwipeResult]{
        return testCheckpoints(pass: pass, checkpoints: discountCheckpoints)
    }

    /**
     * Test the pass against a collection of checkpoints
     *
     * - parameter pass: The pass to test
     * - parameter checkpoints: The collection of checkpoints
     *
     * - returns: The swipe result
     */
    func testCheckpoints(pass: Passable, checkpoints: [Checkpointable]) -> [String: SwipeResult] {
        var results: [String: SwipeResult] = [:]
        checkpoints.forEach({ results.updateValue($0.swipeWithBirthdayCheck(pass: pass), forKey: $0.name) })
        return results
    }
}
