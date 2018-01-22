//
//  ApplicationColor.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 22.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import UIKit

enum ApplicationColor {
    case categoryButtonText
    case categoryButton
    case categoryHighlight
    case subCategoryButtonText
    case subCategoryButton
    case subCategoryHighlight
    
    var value: UIColor {
        switch self {
        case .categoryButtonText: return UIColor(red: 209.0/255.0, green: 194.0/255.0, blue: 224.0/255.0, alpha: 1.0)
        case .categoryButton: return UIColor(red: 138.0/255.0, green: 111.0/255.0, blue: 168.0/255.0, alpha: 1.0)
        case .categoryHighlight: return UIColor.white
        case .subCategoryButtonText: return UIColor(red: 135.0/255.0, green: 126.0/255.0, blue: 144.0/255.0, alpha: 1.0)
        case .subCategoryButton: return UIColor(red: 63.0/255.0, green: 54.0/255.0, blue: 71.0/255.0, alpha: 1.0)
        case .subCategoryHighlight: return UIColor.white
        }
    }
}
