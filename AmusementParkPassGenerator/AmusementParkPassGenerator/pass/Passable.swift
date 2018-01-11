//
//  Passable.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 11.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

import Foundation

protocol Passable {
    var uuid: UUID { get }
    var accesses: [Accessable] { get }
    
    func hasAccess(access: Accessable) -> Bool
}

