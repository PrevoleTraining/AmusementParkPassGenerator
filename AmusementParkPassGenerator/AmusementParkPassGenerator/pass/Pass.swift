//
//  Pass.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 11.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

import Foundation

class Pass: Passable {
    var uuid: UUID
    var accesses: [Accessable]
    var birthDate: Date?
    
    init(accesses: [Accessable]) {
        self.accesses = accesses
        self.uuid = UUID()
    }
    
    convenience init(accesses: [Accessable], birthDate: Date) {
        self.init(accesses: accesses)
        self.birthDate = birthDate
    }
    
    func hasAccess(access: Accessable) -> Bool {
        for accessToEvaluate in accesses {
            if accessToEvaluate.isEqualTo(access) {
                return true
            }
        }
        
        return false
    }
}
