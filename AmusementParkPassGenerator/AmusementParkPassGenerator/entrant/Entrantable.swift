//
//  Entrantable.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 09.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

protocol Entrantable {
    var category: EntrantCategory { get }
    var subCategory: EntrantSubCategory { get }
    
    func accesses() -> [Accessable]
}
