//
//  UIImageView.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 28.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

import UIKit

extension UIImageView {
    @IBInspectable
    override var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }
}
