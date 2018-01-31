//
//  UIView.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 28.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import UIKit

extension UIView {
    /**
     * Apply a corner radius to the border
     */
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    /**
     * Define the border width
     */
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /**
     * Define the border color
     */
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    /**
     * Define the shadow size
     */
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    /**
     * Define the shadow opacity
     */
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    /**
     * Define the shadow distance from the view
     */
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    /**
     * Define the shadow color
     */
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    /**
     * Create a drop shadow to the view.
     * Code from: https://stackoverflow.com/questions/39624675/add-shadow-on-uiview-using-swift-3
     *
     * - parameter color: The color of the shadow
     * - width: The width for the shadow offset
     * - height: The height for the shadow offset
     * - radius: The size of the shadow
     */
    func dropShadow(color: UIColor, width: Int, height: Int, radius: Int) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: CGFloat(width), height: CGFloat(height))
        layer.shadowRadius = CGFloat(radius)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = 1
    }
    
    /**
     * Create a full inner shadow inside the view
     * Code from: https://stackoverflow.com/a/30840942/1618785
     */
    public func addFullInnerShadow() {
        let innerShadow = CALayer()
        innerShadow.frame = bounds
        
        // Shadow path (1pt ring around bounds)
        let path = UIBezierPath(rect: innerShadow.bounds.insetBy(dx: 1, dy: 1))
        let cutout = UIBezierPath(rect: innerShadow.bounds).reversing()
        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        
        // Shadow properties
        innerShadow.shadowColor = UIColor(white: 0, alpha: 1).cgColor
        innerShadow.shadowOffset = CGSize.zero
        innerShadow.shadowOpacity = 1
        innerShadow.shadowRadius = 2
        
        // Add
        layer.addSublayer(innerShadow)
    }
    
    /**
     * Create an inner shadow only at the top of the view
     */
    public func addTopInnerShadow() {
        let innerShadow = CALayer()
        innerShadow.frame = bounds
        innerShadow.cornerRadius = cornerRadius
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: 0.0))
        path.addLine(to: CGPoint(x: bounds.size.width, y: 0.0))
        path.addLine(to: CGPoint(x: bounds.size.width, y: 1.0))
        path.addLine(to: CGPoint(x: 0.0, y: 1.0))
        
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        
        // Shadow properties
        innerShadow.shadowColor = UIColor(white: 0, alpha: 1).cgColor
        innerShadow.shadowOffset = CGSize.zero
        innerShadow.shadowOpacity = 1
        innerShadow.shadowRadius = 2
        
        // Add
        layer.addSublayer(innerShadow)
    }
}
