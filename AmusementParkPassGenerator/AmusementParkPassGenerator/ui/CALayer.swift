    //
//  CALayer.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 22.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

import UIKit
    
extension CALayer {
    var borderUIColor: UIColor {
        set {
            self.borderColor = newValue.cgColor
        }
        
        get {
            return UIColor(cgColor: self.borderColor!)
        }
    }
}
