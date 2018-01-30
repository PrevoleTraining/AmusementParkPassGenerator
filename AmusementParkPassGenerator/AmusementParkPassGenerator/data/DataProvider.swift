//
//  DataProvider.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 23.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

/**
 * Consolidate the various data sources
 */
class DataProvider {
    var entrants: [Entrantable]?
    var projects: [Project]
    var vendors: [Vendor]
    var population: PopulationInfoCollection
    
    /// Different categories present in the entrants
    lazy var categories: [EntrantCategory] = {
        var categories: [EntrantCategory] = []
    
        guard let entrants = entrants else {
            return categories
        }
    
        for entrant in entrants {
            if !categories.contains(entrant.category) {
                categories.append(entrant.category)
            }
        }
        
        return categories
    }()
    
    /// Same for sub categories
    lazy var subCategorie: [EntrantSubCategory] = {
        var subCategories: [EntrantSubCategory] = []
    
        guard let entrants = entrants else {
            return subCategories
        }
    
        for entrant in entrants {
            if let subCategory = entrant.subCategory, !subCategories.contains(subCategory) {
                subCategories.append(subCategory)
            }
        }
    
        return subCategories
    }()
    
    /**
     * Constructor
     */
    init() {
        // Load the four data collection used by the application
        do {
            var array = try PlistConverter.array(fromFile: "entrants", ofType: "plist")
            entrants = try EntrantableUnarchiver.entrants(fromArray: array)
            
            array = try PlistConverter.array(fromFile: "projects", ofType: "plist")
            projects = try AreaRestrictedEntrantUnarchiver.projects(fromArray: array)
            
            array = try PlistConverter.array(fromFile: "vendors", ofType: "plist")
            vendors = try AreaRestrictedEntrantUnarchiver.vendors(fromArray: array)
            
            array = try PlistConverter.array(fromFile: "population", ofType: "plist")
            population = try PopulationInfoUnarchiver.population(fromArray: array)
        } catch let error {
            fatalError("\(error)")
        }
    }
    
    /**
     * Retrieve the sub categories available in the application according
     * to the data loaded.
     *
     * returns: The collection of sub categories
     */
    func subCategories() -> [EntrantSubCategory] {
        var subCategories: [EntrantSubCategory] = []
        
        guard let entrants = entrants else {
            return subCategories
        }
        
        for entrant in entrants {
            if let subCategory = entrant.subCategory, !subCategories.contains(subCategory) {
                subCategories.append(subCategory)
            }
        }
        
        return subCategories
    }
    
    /**
     * Try to find an entrant corresponding to the category and subcategory
     *
     * Parameters:
     * - category: The category
     * - subCategory: The sub category
     *
     * - returns: An entrant if found in the corredponing collection
     */
    func findEntrantFor(category: EntrantCategory, subCategory: EntrantSubCategory? = nil) -> Entrantable? {
        if let entrants = entrants {
            for entrant in entrants {
                if entrant.category == category && entrant.subCategory == subCategory {
                    return entrant
                }
            }
        }
        
        return nil
    }
    
    /**
     * Find a project by its number identifier
     *
     * - parameter number: The project number
     *
     * - returns: A project if found
     */
    func findProject(number: String?) -> Project? {
        if let number = number {
            return projects.filter({ $0.number == number }).first
        } else {
            return nil
        }
    }
    
    /**
     * Find a vendor by its name identifier
     *
     * - parameter name: The vendor name
     *
     * - returns: A vendor if found
     */
    func findVendor(name: String?) -> Vendor? {
        if let name = name {
            return vendors.filter({ $0.name == name }).first
        } else {
            return nil
        }
    }
}
