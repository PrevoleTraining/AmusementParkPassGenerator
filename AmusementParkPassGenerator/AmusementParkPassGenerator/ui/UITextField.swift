//
//  UITextField.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 26.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import UIKit

extension UITextField {
    @IBInspectable
    var leftRightPadding: CGFloat {
        get {
            if let leftView = leftView {
                return leftView.frame.width
            } else {
                return 0
            }
        }
        set {
            let leftRightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: newValue, height: 1.0))
            leftView = leftRightView
            rightView = leftRightView
            leftViewMode = .always
            rightViewMode = .always
        }
    }
}
