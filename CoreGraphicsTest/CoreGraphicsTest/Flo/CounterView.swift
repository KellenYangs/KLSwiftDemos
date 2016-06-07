//
//  CounterView.swift
//  CoreGraphicsTest
//
//  Created by bcmac3 on 16/5/26.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

let NoOfGlasses = 8
let π: CGFloat = CGFloat(M_PI)

@IBDesignable
class CounterView: UIView {
    
    /// 当前计数
    @IBInspectable var counter: Int = 5 {
        didSet {
            if counter <= NoOfGlasses && counter >= 0 {
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var outlineColor: UIColor = UIColor.blueColor()
    @IBInspectable var counterColor: UIColor = UIColor.orangeColor()
    
    override func drawRect(rect: CGRect) {
        // 1. 外轮廓
        let center: CGPoint = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = max(bounds.width, bounds.height) / 2
        
        let arcWidth: CGFloat = radius * 2 / 3
        
        let startAngle: CGFloat = 3 * π / 4
        let endAngle: CGFloat = π / 4

        
        let path = UIBezierPath(arcCenter: center, radius: radius - arcWidth / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        // 2. 当前计数轮廓
        let angleDifference: CGFloat = 2 * π - startAngle + endAngle
        let arcLengthPerGlass = angleDifference / CGFloat(NoOfGlasses)
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        let outlinePath = UIBezierPath(arcCenter: center, radius: radius - 2.5, startAngle: startAngle, endAngle:outlineEndAngle, clockwise: true)
        outlinePath.addArcWithCenter(center, radius: radius - arcWidth + 2.5, startAngle: outlineEndAngle, endAngle: startAngle, clockwise: false)
        outlinePath.closePath()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = 5.0
        outlinePath.stroke()
        
        // 3.小指标
        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        outlineColor.setFill()
        
        let markerWidth: CGFloat = 5.0
        let markerSize: CGFloat = 10.0
        
        let markerPath = UIBezierPath(rect: CGRect(x: -markerWidth/2, y: 0, width: markerWidth, height: markerSize))
        
        // 移动
        CGContextTranslateCTM(context, rect.width/2, rect.height/2)
        
        for i in 1...NoOfGlasses {
            CGContextSaveGState(context)
            
            let angle = arcLengthPerGlass * CGFloat(i) + startAngle - π/2
            
            CGContextRotateCTM(context, angle)
            CGContextTranslateCTM(context, 0, rect.height/2 - markerSize)
            
            markerPath.fill()
            
            CGContextRestoreGState(context)
        }
        
        CGContextRestoreGState(context)
    }

}
