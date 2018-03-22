//
//  LabelMedium.swift
//  EddystoneConnectionSample
//
//  Created by Edwin Alvarado on 3/22/18.
//  Copyright © 2018 Edwin Alvarado. All rights reserved.
//

import Foundation
import UIKit

class LabelMedium: UILabel {
    // LogoCategoryc class
    var customTextColor: UIColor?
    var size: CGFloat?
    var letterSpacing: CGFloat?
    var lineSpacing: CGFloat?
    var aligment: NSTextAlignment?
    
    init(text: String, size: CGFloat, letterSpacing: CGFloat = 0, lineSpacing: CGFloat = 4, aligment: NSTextAlignment = NSTextAlignment.left){
        // This line is needed to run the super class constructor.
        // The frame is set to zero, because the size of the class
        // will be changed in the future
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        self.size = size
        self.letterSpacing = letterSpacing
        self.lineSpacing = lineSpacing
        self.aligment = aligment
        
        self.font = UIFont(name: "Now-medium", size: size)
        
        self.textColor = textColor
        self.textAlignment = aligment
        
        //self.attributedText = text.createAttributeString(font: self.font, color: textColor, spacing: lineSpacing, letterSpacing: letterSpacing)
        
        //self.textAlignment = self.aligment!
        
        
        self.text = text
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setAttributedStringText(text: String){
        //self.attributedText = text.createAttributeString(font: self.font, color: self.customTextColor!, spacing: self.lineSpacing!, letterSpacing: self.letterSpacing!)
        //self.textAlignment = self.aligment!
        self.text = text
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

