//
//  PushButtonView.swift
//  CoreGraphicsTest
//
//  Created by bcmac3 on 16/5/26.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

@IBDesignable

class PushButtonView: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.greenColor()
    @IBInspectable var isAddButton: Bool = true
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect);
        fillColor.setFill()
        path.fill()
        
        let assistWidth: CGFloat = 0.5
        let plusHieght: CGFloat = 3.0
        let plusWidth: CGFloat  = min(bounds.width, bounds.height) * 0.6
        
        let plusPath = UIBezierPath()
        plusPath.lineWidth = plusHieght
        plusPath.moveToPoint(CGPoint(x: bounds.width / 2 - plusWidth / 2 + assistWidth, y: bounds.height / 2 + assistWidth))
        
        plusPath.addLineToPoint(CGPoint(x: bounds.width / 2 + plusWidth / 2 + assistWidth, y: bounds.height / 2 + assistWidth))
        UIColor.whiteColor().setStroke()
        plusPath.stroke()
        
        if isAddButton {
            let plusRect: CGRect = CGRect(x: bounds.width / 2 - plusHieght / 2 + assistWidth, y: bounds.height / 2 - plusWidth / 2 + 0.5, width: plusHieght, height: plusWidth)
            let plusHPath = UIBezierPath(rect: plusRect)
            UIColor.whiteColor().setFill()
            plusHPath.fill()
        }

    }

}
