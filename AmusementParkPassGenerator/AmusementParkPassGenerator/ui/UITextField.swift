//
//  UITextField.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 26.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import UIKit

extension UITextField {
    func padding(width: Double) {
        let leftRightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 1.0))
        self.leftView = leftRightView
        self.rightView = leftRightView
        self.leftViewMode = .always
        self.rightViewMode = .always
    }
    
    func border(color: UIColor, width: Double? = nil, cornerRadius: Double? = nil) {
        self.layer.borderColor = color.cgColor
        
        if let width = width {
            self.layer.borderWidth = CGFloat(width)
        }
        
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = CGFloat(cornerRadius)
        }
    }
}
