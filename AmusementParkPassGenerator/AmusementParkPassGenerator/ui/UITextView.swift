//
//  UITextView.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 27.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

import UIKit

extension UITextView {
    func padding(width: Double) {
        let cgWidth = CGFloat(width)
        contentInset = UIEdgeInsets(top: cgWidth, left: cgWidth, bottom: cgWidth, right: cgWidth)
    }
}
