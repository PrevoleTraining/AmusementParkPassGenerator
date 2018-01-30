//
//  PopulationInfoCollection.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 27.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import Foundation

/**
 * A collection to store the population info which is in
 * fact the sample data used to populate the UI
 *
 * The sample data are identified by the category and
 * the sub category.
 */
class PopulationInfoCollection {
    var population: [PopulationInfo] = []
    
    /**
     * Add a person to the collection
     *
     * - parameter person: The person to add
     */
    func add(person: PopulationInfo) {
        population.append(person)
    }
    
    /**
     * Find a sample person for the UI population
     *
     * - parameter category: The category
     * - parameter subCategory: The sub category
     *
     * - returns: The population info found
     */
    func findBy(category: EntrantCategory, subCategory: EntrantSubCategory? = nil) -> PopulationInfo? {
        return population.first(where: { $0.category == category && $0.subCategory == subCategory })
    }
}
