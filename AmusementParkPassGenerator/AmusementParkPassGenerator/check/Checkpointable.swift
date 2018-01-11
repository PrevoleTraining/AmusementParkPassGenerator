//
//  Checkpointable.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 11.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

protocol Checkpointable {
    func check(pass: Passable) -> Bool
}
