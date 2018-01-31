//
//  UIImageView.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 28.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import UIKit

extension UIImageView {
    /**
     * Apply a corner radius to the image view
     */
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
