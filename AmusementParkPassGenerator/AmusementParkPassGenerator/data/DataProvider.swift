//
//  DataProvider.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 23.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

class DataProvider {
    var entrants: [Entrantable]?
    var projects: [Project]
    var vendors: [Vendor]
    var population: PopulationInfoCollection
    
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
    
    init() {
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
    
    func findProject(number: String?) -> Project? {
        if let number = number {
            return projects.filter({ $0.number == number }).first
        } else {
            return nil
        }
    }
    
    func findVendor(name: String?) -> Vendor? {
        if let name = name {
            return vendors.filter({ $0.name == name }).first
        } else {
            return nil
        }
    }
}
