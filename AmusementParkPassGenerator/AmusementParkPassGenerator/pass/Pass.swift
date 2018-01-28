//
//  Pass.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 11.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import Foundation

/**
 * Passable implementation
 */
class Pass: Passable {
    var uuid: UUID
    
    var category: EntrantCategory
    var subCategory: EntrantSubCategory?
    
    var accesses: [Accessable]
    var birthDate: Date?
    
    /**
     * Constructor
     *
     * - parameter accesses: The list of granted accesses
     */
    init(accesses: [Accessable]?, categoryAndSubCategory: CategoryAndSubCategory, areaRestrictedEntrantables: [AreaRestrictedEntrantable?]?) {
        if let accesses = accesses {
            self.accesses = accesses
        } else {
            self.accesses = []
        }
        
        if let restrictedEntrantables = areaRestrictedEntrantables {
            for restrictedEntrantable in restrictedEntrantables {
                if let restrictedEntrantable = restrictedEntrantable, let areaAccesses = restrictedEntrantable.accesses {
                    for areaAccess in areaAccesses {
                        self.accesses.append(areaAccess)
                    }
                }
            }
        }
        
        self.category = categoryAndSubCategory.category
        self.subCategory = categoryAndSubCategory.subCategory
        
        self.uuid = UUID()
    }
    
    func hasAccess(access: Accessable) -> Bool {
        return findAccess(access: access) != nil
    }
    
    func findAccess(access: Accessable) -> Accessable? {
        for accessToEvaluate in accesses {
            if accessToEvaluate.isEqualTo(access) {
                return accessToEvaluate
            }
        }
        
        return nil
    }
}

