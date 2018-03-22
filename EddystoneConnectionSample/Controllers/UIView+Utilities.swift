//
//  Extensions.swift
//  EddystoneConnectionSample
//
//  Created by Edwin Alvarado on 3/22/18.
//  Copyright © 2018 Edwin Alvarado. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func createGradientLayer(colors: [CGColor]){
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        
        gradientLayer.colors = colors
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /**
     Rounds the given set of corners to the specified radius
     
     - parameter corners: Corners to round
     - parameter radius:  Radius to round to
     */
    
    func makeCircle(){
        self.layoutIfNeeded()
        
        let radius: CGFloat!
        
        if (self.frame.size.width <= self.frame.size.height) {
            radius = self.frame.size.width / 2
        }
        else {
            radius = self.frame.size.height / 2
        }
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    
    func round(corners: UIRectCorner, radius: CGFloat) {
        _round(corners: corners, radius: radius)
    }
    
    /**
     Rounds the given set of corners to the specified radius with a border
     
     - parameter corners:     Corners to round
     - parameter radius:      Radius to round to
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = _round(corners: corners, radius: radius)
        addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
    }
    
    /**
     Fully rounds an autolayout view (e.g. one with no known frame) with the given diameter and border
     
     - parameter diameter:    The view's diameter
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func fullyRound(diameter: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = diameter / 2
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor;
    }
    func buildingAnchorConstraint(referenceView: UIView? = nil, leftAnchorConstant: CGFloat? = nil, rightAnchorConstant: CGFloat? = nil, topAnchorConstant: CGFloat? = nil, bottomAnchorConstant: CGFloat? = nil, heightAnchorMultiplier: CGFloat? = nil, widthAnchorMultiplier: CGFloat? = nil,  centerXAnchor: Bool = false, centerYAnchor: Bool = false,fixedHeight: CGFloat? = nil, fixedWidth: CGFloat? = nil){
        
        let referenceViewFlag: Bool = referenceView != nil
        
        if (leftAnchorConstant != nil && referenceViewFlag){
            leftAnchorConstraint(referenceView: referenceView!, constant: leftAnchorConstant!)
        }
        if (rightAnchorConstant != nil && referenceViewFlag){
            rightAnchorConstraint(referenceView: referenceView!, constant: rightAnchorConstant!)
        }
        if (topAnchorConstant != nil && referenceViewFlag){
            topAnchorConstraint(referenceView: referenceView!, constant: topAnchorConstant!)
        }
        if (bottomAnchorConstant != nil && referenceViewFlag){
            bottomAnchorConstraint(referenceView: referenceView!, constant: bottomAnchorConstant!)
        }
        if (widthAnchorMultiplier != nil && referenceViewFlag){
            widthAnchorConstraint(referenceView: referenceView!, multiplier: widthAnchorMultiplier!)
        }
        if (heightAnchorMultiplier != nil && referenceViewFlag){
            heightAnchorConstraint(referenceView: referenceView!, multiplier: heightAnchorMultiplier!)
        }
        if (centerXAnchor && referenceViewFlag){
            centerXAnchorConstraint(referenceView: referenceView!)
        }
        
        if (centerYAnchor && referenceViewFlag){
            centerYAnchorConstraint(referenceView: referenceView!)
        }
        
        
        if (fixedHeight != nil){
            fixedHeightAnchorConstraint(constant: fixedHeight!)
        }
        
        if (fixedWidth != nil){
            fixedWidthAnchorConstraint(constant: fixedWidth!)
        }
        
        
    }
    
    
    func topAnchorConstraint(referenceView: UIView, constant: CGFloat = 0){
        self.topAnchor.constraint(equalTo: referenceView.topAnchor, constant: constant).isActive = true
    }
    
    func bottomAnchorConstraint(referenceView: UIView, constant: CGFloat = 0){
        self.bottomAnchor.constraint(equalTo: referenceView.bottomAnchor, constant: constant).isActive = true
    }
    
    func leftAnchorConstraint(referenceView: UIView, constant: CGFloat = 0){
        self.leftAnchor.constraint(equalTo: referenceView.leftAnchor, constant: constant).isActive = true
    }
    
    func rightAnchorConstraint(referenceView: UIView, constant: CGFloat = 0){
        self.rightAnchor.constraint(equalTo: referenceView.rightAnchor, constant: constant).isActive = true
    }
    
    func heightAnchorConstraint(referenceView: UIView, multiplier: CGFloat = 1){
        self.heightAnchor.constraint(equalTo: referenceView.heightAnchor, multiplier: multiplier).isActive = true
    }
    
    func widthAnchorConstraint(referenceView: UIView, multiplier: CGFloat = 1){
        self.widthAnchor.constraint(equalTo: referenceView.widthAnchor, multiplier: multiplier).isActive = true
    }
    
    func fixedHeightAnchorConstraint(constant: CGFloat){
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func fixedWidthAnchorConstraint(constant: CGFloat){
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func centerXAnchorConstraint(referenceView: UIView){
        self.centerXAnchor.constraint(equalTo: referenceView.centerXAnchor).isActive = true
    }
    
    func centerYAnchorConstraint(referenceView: UIView){
        self.centerYAnchor.constraint(equalTo: referenceView.centerYAnchor).isActive = true
    }
    
}

private extension UIView {
    
    @discardableResult func _round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }
    
    func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
}
