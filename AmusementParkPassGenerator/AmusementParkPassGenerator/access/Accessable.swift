//
//  Accessable.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 09.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

protocol Accessable: Descriptable {
    func isEqualTo(_ rhs: Accessable) -> Bool
}

