//
//  Entrant.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 09.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

/**
 * Access profile
 */
class Entrant: Entrantable {
    var category: EntrantCategory
    var subCategory: EntrantSubCategory?
    
    var accesses: [Accessable]?
    var personalInfo: [PersonalInfo]?

    /**
     * Constructor
     *
     * - parameters:
     *  - category: The category
     *  - subCategory: The sub category
     */
    init(category: EntrantCategory, subCategory: EntrantSubCategory) {
        self.category = category
        self.subCategory = subCategory
    }
}
