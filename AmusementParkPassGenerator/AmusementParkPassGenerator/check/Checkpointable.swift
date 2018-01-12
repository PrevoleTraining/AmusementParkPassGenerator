//
//  Checkpointable.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 11.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

import Foundation

protocol Checkpointable {
    func swipe(pass: Passable) -> SwipeResult
}

extension Checkpointable {
    func swipeWithBirthdayCheck(pass: Passable) -> SwipeResult {
        var result = swipe(pass: pass)
        
        switch result.status {
        case .granted, .grantedForDiscount:
            if let birthDate = pass.birthDate, Date().isToday(birthDate: birthDate) {
                result.add(message: "Happy Birthday! Enjoy the day in our Theme Park")
            }
            return result
        default: return result
        }
    }
}
