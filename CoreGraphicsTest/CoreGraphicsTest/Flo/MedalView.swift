//
//  MedalView.swift
//  CoreGraphicsTest
//
//  Created by bcmac3 on 16/5/30.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

@IBDesignable
class MedalView: UIImageView {

    lazy var medalImage: UIImage =  self.createMedalImage()
    
    func showMedal(show: Bool) {
        if show {
            image = medalImage
        }else {
            image = nil
        }
    }
    
    func createMedalImage() -> UIImage {
        print("creating Medal Image!")
        
        let size = CGSize(width:120, height: 200)
        let darkGoldColor = UIColor(red: 0.6, green: 0.5, blue: 0.15, alpha: 1.0)
        let midGoldColor = UIColor(red: 0.86, green: 0.73, blue: 0.3, alpha: 1.0)
        let lightGoldColor = UIColor(red: 1.0, green: 0.98, blue: 0.9, alpha: 1.0)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        // shadows 阴影
        let shadow: UIColor = UIColor.blackColor().colorWithAlphaComponent(0.80)
        let shadowOff = CGSizeMake(2.0, 2.0)
        let shadowBlurRadius: CGFloat = 5
        
        CGContextSetShadowWithColor(context, shadowOff, shadowBlurRadius, shadow.CGColor)
        CGContextBeginTransparencyLayer(context, nil)
        
        
        // lower Ribben
        let lowerRibbenPath = UIBezierPath()
        lowerRibbenPath.moveToPoint(CGPointMake(0, 0))
        lowerRibbenPath.addLineToPoint(CGPointMake(40, 0))
        lowerRibbenPath.addLineToPoint(CGPointMake(78, 70))
        lowerRibbenPath.addLineToPoint(CGPointMake(38, 70))
        lowerRibbenPath.closePath()
        UIColor.redColor().setFill()
        lowerRibbenPath.fill()
        
        // clasp
        let claspPath = UIBezierPath(roundedRect: CGRectMake(36, 62, 43, 20), cornerRadius: 5)
        claspPath.lineWidth = 5
        darkGoldColor.setStroke()
        claspPath.stroke()
        
        // Medallion
        let medallionPath = UIBezierPath(ovalInRect: CGRect(origin: CGPointMake(8, 72), size: CGSizeMake(100, 100)))
        CGContextSaveGState(context)
        medallionPath.addClip()
        let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [darkGoldColor.CGColor, midGoldColor.CGColor,lightGoldColor.CGColor], [0, 0.51, 1])
        CGContextDrawLinearGradient(context, gradient, CGPointMake(40, 40), CGPointMake(100, 162), .DrawsBeforeStartLocation)
        CGContextRestoreGState(context)
        
        var transform = CGAffineTransformMakeScale(0.8, 0.8)
        transform = CGAffineTransformTranslate(transform, 15, 30)
        medallionPath.lineWidth = 2.0
        medallionPath.applyTransform(transform)
        medallionPath.stroke()
        
        // Upper Ribben
        let upperRibbenPath = UIBezierPath()
        upperRibbenPath.moveToPoint(CGPointMake(68, 0))
        upperRibbenPath.addLineToPoint(CGPointMake(108, 0))
        upperRibbenPath.addLineToPoint(CGPointMake(78, 70))
        upperRibbenPath.addLineToPoint(CGPointMake(38, 70))
        UIColor.blueColor().setFill()
        upperRibbenPath.fill()
        
        // number 1
        let numberOne = "1"
        let numberOneRect = CGRectMake(47, 100, 50, 50)
        let font = UIFont(name: "Academy Engraved LET", size: 60)
        let numberOneAtttributes = [NSFontAttributeName : font!, NSForegroundColorAttributeName : darkGoldColor]
        numberOne.drawInRect(numberOneRect, withAttributes:numberOneAtttributes)
        
        CGContextEndTransparencyLayer(context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image;
    }
}
