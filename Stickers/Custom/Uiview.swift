//
//  Uiview.swift
//  Stickers
//
//  Created by  Ahmed’s MacBook Pro on 4/16/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
@IBDesignable
final class SideBorders: UIView {
    @IBInspectable var topColor: UIColor = UIColor.clear
    @IBInspectable var topWidth: CGFloat = 0
    
    @IBInspectable var rightColor: UIColor = UIColor.clear
    @IBInspectable var rightWidth: CGFloat = 0
    
    @IBInspectable var bottomColor: UIColor = UIColor.clear
    @IBInspectable var bottomWidth: CGFloat = 0
    
    @IBInspectable var leftColor: UIColor = UIColor.clear
    @IBInspectable var leftWidth: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        let topBorder = CALayer()
        topBorder.backgroundColor = topColor.cgColor
        topBorder.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: topWidth)
        self.layer.addSublayer(topBorder)
        
        let rightBorder = CALayer()
        rightBorder.backgroundColor = rightColor.cgColor
        rightBorder.frame = CGRect(x: self.frame.size.width - rightWidth, y: 0, width: rightWidth, height: self.frame.size.height)
        self.layer.addSublayer(rightBorder)
        
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = bottomColor.cgColor
        bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - bottomWidth, width: self.frame.size.width, height: bottomWidth)
        self.layer.addSublayer(bottomBorder)
        
        let leftBorder = CALayer()
        leftBorder.backgroundColor = leftColor.cgColor
        leftBorder.frame = CGRect(x: 0, y: self.frame.size.height - leftWidth, width: self.frame.size.width, height: leftWidth)
        self.layer.addSublayer(leftBorder)
    }
}
