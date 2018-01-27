//
//  PopulationInfoCollection.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 27.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

import Foundation

class PopulationInfoCollection {
    var population: [PopulationInfo] = []
    
    func add(person: PopulationInfo) {
        population.append(person)
    }
    
    func findBy(category: EntrantCategory, subCategory: EntrantSubCategory? = nil) -> PopulationInfo? {
        return population.first(where: { $0.category == category && $0.subCategory == subCategory })
    }
}
