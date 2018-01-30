//
//  Project.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 22.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

/**
 * Represent a project of employees of the park
 */
class Project: AreaRestrictedEntrantable, Identifiable, Descriptable {
    var accesses: [AreaAccess]?

    let number: String
    
    /**
     * Constructor
     *
     * - parameter number: The project's number
     */
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
