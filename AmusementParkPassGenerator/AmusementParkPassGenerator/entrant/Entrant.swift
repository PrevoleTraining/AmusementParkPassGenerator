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
    init(category: EntrantCategory, subCategory: EntrantSubCategory? = nil) {
        self.category = category
        self.subCategory = subCategory
    }
    
    /**
     * Constructor
     *
     * - parameter categoryAndSubCategory: The category and subCategory tuple
     */
    convenience init(categoryAndSubCategory: CategoryAndSubCategory) {
        self.init(category: categoryAndSubCategory.category, subCategory: categoryAndSubCategory.subCategory)
    }
    
    func description() -> String {
        return "Category: \(category.rawValue), subCategory: \(subCategory?.rawValue ?? "n/a")"
    }
}

/**
 * An alias type of a tuple that contains a category and sub category
 */
typealias CategoryAndSubCategory = (category: EntrantCategory, subCategory: EntrantSubCategory?)
