//
//  Pass.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 11.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

class Pass: Passable {
    var accesses: [Accessable]
    
    init(accesses: [Accessable]) {
        self.accesses = accesses
    }
    
    func hasAccess(access: Accessable) -> Bool {
        for ownAccess in accesses {
            if ownAccess == access {
                return true
            }
        }
        
        return false
    }
}
