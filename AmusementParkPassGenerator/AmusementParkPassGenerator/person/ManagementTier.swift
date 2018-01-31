//
//  ManagementTier.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 22.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

/**
 * The management tiers
 */
enum ManagementTier: String, Descriptable {
    case shift
    case general
    case senior
    
    func description() -> String {
        return self.rawValue.capitalizingFirstLetter()
    }
}
