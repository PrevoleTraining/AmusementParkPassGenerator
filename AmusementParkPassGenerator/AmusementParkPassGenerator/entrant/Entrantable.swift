//
//  Entrantable.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 09.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

protocol Entrantable {
    var category: EntrantCategory { get }
    var subCategory: EntrantSubCategory? { get }
    
    var accesses: [Accessable]? { get }
    var personalInfo: [PersonalInfo]? { get }
}
