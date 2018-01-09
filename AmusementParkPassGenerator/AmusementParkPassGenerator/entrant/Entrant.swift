//
//  Entrant.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 09.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

class Entrant: Entrantable {
    var category: EntrantCategory
    var subCategory: EntrantSubCategory
    
    init(category: EntrantCategory, subCategory: EntrantSubCategory) {
        self.category = category
        self.subCategory = subCategory
    }
    
    func accesses() -> [Accessable] {
        return []
    }
}
