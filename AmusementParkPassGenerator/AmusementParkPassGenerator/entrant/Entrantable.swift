//
//  Entrantable.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 09.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

/**
 * An entrant is kind of access profile to
 * define persons' pass
 */
protocol Entrantable {
    // The category and sub category
    var category: EntrantCategory { get }
    var subCategory: EntrantSubCategory? { get }
    
    // The collection of accesses granted into the park
    var accesses: [Accessable]? { get }

    // The collection of required personal information
    var personalInfo: [PersonalInfo]? { get }
}

extension Entrantable {
    var categoryAndSubCategory: CategoryAndSubCategory {
        return CategoryAndSubCategory(category: category, subCategory: subCategory)
    }
}
