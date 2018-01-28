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
    case fieldText
    case fieldTextError
    case fieldBorder
    case fieldBorderError
    case fieldBackground
    case fieldBackgroundDisabled
    case labelError
    case label
    case simulatorGreenText
    case simulatorRedText
    
    var value: UIColor {
        switch self {
        case .categoryButtonText: return UIColor(red: 209.0/255.0, green: 194.0/255.0, blue: 224.0/255.0, alpha: 1.0)
        case .categoryButton: return UIColor(red: 138.0/255.0, green: 111.0/255.0, blue: 168.0/255.0, alpha: 1.0)
        case .categoryHighlight: return UIColor.white
        case .subCategoryButtonText: return UIColor(red: 135.0/255.0, green: 126.0/255.0, blue: 144.0/255.0, alpha: 1.0)
        case .subCategoryButton: return UIColor(red: 63.0/255.0, green: 54.0/255.0, blue: 71.0/255.0, alpha: 1.0)
        case .subCategoryHighlight: return UIColor.white
        case .fieldText: return UIColor.black
        case .fieldBorder: return UIColor(red: 197.0/255.0, green: 192.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        case .fieldBorderError, .labelError, .fieldTextError, .simulatorRedText: return UIColor(red: 220.0/255.0, green: 89.0/255.0, blue: 96.0/255.0, alpha: 1.0)
        case .fieldBackground: return UIColor.white
        case .fieldBackgroundDisabled: return UIColor(red: 226/255.0, green: 222.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        case .label: return UIColor(red: 95.0/255.0, green: 93.0/255.0, blue: 97.0/255.0, alpha: 1.0)
        case .simulatorGreenText: return UIColor(red: 90.0/255.0, green: 149.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        }
    }
}
