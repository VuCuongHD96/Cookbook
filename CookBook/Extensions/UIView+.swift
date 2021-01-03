//
//  UIView+.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 10/27/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

extension UIView {
    func setGradientColor(colorOne: UIColor?, colorTwo: UIColor?, orientation: GradientOrientation) {
        guard let cgColorOne = colorOne?.cgColor,
            let cgColorTwo = colorTwo?.cgColor else {
                return
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [cgColorOne, cgColorTwo]
        let arrayPoint = orientation.getPoints()
        gradientLayer.startPoint = arrayPoint[0]
        gradientLayer.endPoint = arrayPoint[1]
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at:0)
    }
}
