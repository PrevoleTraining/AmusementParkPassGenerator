//
//  UIButton.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 26.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(text: String, selector: Selector, target: ViewController, backgroundColor: UIColor, titleColor: UIColor) {
        self.init()

        self.backgroundColor = backgroundColor
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(text, for: .normal)
        self.addTarget(target, action: selector, for: .touchUpInside)
    }
}
