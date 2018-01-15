//
//  Passable.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 11.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import Foundation

protocol Passable {
    var uuid: UUID { get }
    var accesses: [Accessable] { get }
    var birthDate: Date? { get }
    
    func hasAccess(access: Accessable) -> Bool
    
    func findAccess(access: Accessable) -> Accessable?
}

