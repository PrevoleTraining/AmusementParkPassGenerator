//
//  CheckpointSimulator.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 28.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

class CheckpointSimulator {
    let areaCheckpoints: [Checkpointable] = [
        AreaCheckpoint(name: "Amusement test zone", access: .amusement),
        AreaCheckpoint(name: "Kitchen test zone", access: .kitchen),
        AreaCheckpoint(name: "Ride control test zone", access: .rideControl),
        AreaCheckpoint(name: "Maintenance test zone", access: .maintenance),
        AreaCheckpoint(name: "Office test zone", access: .office)
    ]
    
    let rideCheckpoints: [Checkpointable]  = [
        RideCheckpoint(name: "RollerCoaster test ride", access: .allRides),
        RideCheckpoint(name: "RollerCoaster fast lane test ride", access: .skipRideLines)
    ]
    
    let discountCheckpoints: [Checkpointable]  = [
        DiscountCheckpoint(name: "Burgers test shop", access: .food(discount: 0)),
        DiscountCheckpoint(name: "Souvenirs test shop", access: .merchandise(discount: 0))
    ]
    
    func testAreaCheckpoints(pass: Passable) -> [String: SwipeResult]{
        return testCheckpoints(pass: pass, checkpoints: areaCheckpoints)
    }
    
    func testRideCheckpoints(pass: Passable) -> [String: SwipeResult]{
        return testCheckpoints(pass: pass, checkpoints: rideCheckpoints)
    }

    func testDiscountCheckpoints(pass: Passable) -> [String: SwipeResult]{
        return testCheckpoints(pass: pass, checkpoints: discountCheckpoints)
    }

    func testCheckpoints(pass: Passable, checkpoints: [Checkpointable]) -> [String: SwipeResult] {
        var results: [String: SwipeResult] = [:]
        checkpoints.forEach({ results.updateValue($0.swipeWithBirthdayCheck(pass: pass), forKey: $0.name) })
        return results
    }
}
