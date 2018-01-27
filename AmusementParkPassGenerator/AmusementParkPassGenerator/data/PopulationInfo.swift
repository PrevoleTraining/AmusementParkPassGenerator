//
//  PopulationInfo.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 27.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

import Foundation

class PopulationInfo: PersonBase {
    var category: EntrantCategory;
    var subCategory: EntrantSubCategory?
    
    var project: String?
    var vendor: String?
    
    var birthDate: String?
    var visitDate: String?
    
    var managementTier: String?
    
    init(categoryAndSubCategory: CategoryAndSubCategory) {
        self.category = categoryAndSubCategory.category
        self.subCategory = categoryAndSubCategory.subCategory
    }
}
