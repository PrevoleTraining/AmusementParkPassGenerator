//
//  Identifiable.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 22.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

protocol Identifiable {
    associatedtype Identity
    
    func isEqual(rhs: Identity) -> Bool
}
