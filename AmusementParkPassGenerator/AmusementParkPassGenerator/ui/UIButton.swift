//
//  UIButton.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 26.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import UIKit

extension UIButton {
    /**
     * Convenient way to build a new button
     *
     * - parameter text: The text of the button
     * - parameter selector: The target action on touchUpInside
     * - parameter target: The target class
     * - parameter backgroundColor: The color to apply to the background
     * - parameter titleColor: The color to apply to the font
     */
    convenience init(text: String, selector: Selector, target: ViewController, backgroundColor: UIColor, titleColor: UIColor) {
        self.init()

        self.backgroundColor = backgroundColor
        setTitleColor(titleColor, for: .normal)
        setTitle(text, for: .normal)
        addTarget(target, action: selector, for: .touchUpInside)
    }
}
