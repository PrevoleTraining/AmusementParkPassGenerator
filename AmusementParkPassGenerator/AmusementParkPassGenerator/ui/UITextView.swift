//
//  UITextView.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 27.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

import UIKit

extension UITextView {
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
