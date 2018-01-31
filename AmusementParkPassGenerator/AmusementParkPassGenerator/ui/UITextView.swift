//
//  UITextView.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 27.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import UIKit

extension UITextView {
    /**
     * Add a padding on the four inside sides of the text view
     */
    @IBInspectable
    var padding: CGFloat {
        get {
            return contentInset.top
        }
        set {
            contentInset = UIEdgeInsets(top: newValue, left: newValue, bottom: newValue, right: newValue)
        }
    }
}
