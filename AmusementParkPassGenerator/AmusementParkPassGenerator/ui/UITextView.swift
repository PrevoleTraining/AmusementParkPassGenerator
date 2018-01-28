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
    
    // https://stackoverflow.com/questions/41387549/how-to-align-text-inside-textview-vertically
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}
