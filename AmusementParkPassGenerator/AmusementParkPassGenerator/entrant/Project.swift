//
//  Project.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 22.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

class Project: AreaRestrictedEntrant, Identifiable, Descriptable {
    var accesses: [AreaAccess]?

    let number: String
    
    init(number: String) {
        self.number = number
    }
    
    func description() -> String {
        return "Project number: \(number)"
    }
    
    func isEqual(rhs: Project) -> Bool {
        return number == rhs.number
    }
}
