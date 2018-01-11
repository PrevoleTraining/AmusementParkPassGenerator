//
//  Passable.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 11.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

protocol Passable {
    var accesses: [Accessable] { get }
    
    func hasAccess(access: Accessable) -> Bool
}
