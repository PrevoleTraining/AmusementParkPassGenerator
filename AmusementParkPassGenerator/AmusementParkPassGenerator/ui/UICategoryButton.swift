//
//  UICategoryButton.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 22.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import UIKit

class UICategoryButton: UIButton {
    let category: EntrantCategory?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(category: EntrantCategory) {
        super.init()
        self.category = category
    }
}
