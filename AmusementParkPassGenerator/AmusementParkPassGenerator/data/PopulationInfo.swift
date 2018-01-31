//
//  PopulationInfo.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 27.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import Foundation

/**
 * Common fields that describe a person which can be part
 * of the sample population or be a real guest.
 */
class PopulationInfo: PersonBase {
    var category: EntrantCategory;
    var subCategory: EntrantSubCategory?
    
    var project: String?
    var vendor: String?
    
    var birthDate: String?
    var visitDate: String?
    
    var managementTier: String?
    
    /**
     * Constructor
     *
     * - parameter categoryAndSubCategory: The category and sub category grouped
     */
    init(categoryAndSubCategory: CategoryAndSubCategory) {
        self.category = categoryAndSubCategory.category
        self.subCategory = categoryAndSubCategory.subCategory
    }
}
