//
//  PushButtonView.swift
//  CoreGraphicsTest
//
//  Created by bcmac3 on 16/5/26.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

/// 加号按钮 or 减号按钮
@IBDesignable
class PushButtonView: UIButton {
    
    /// 按钮颜色
    @IBInspectable var fillColor: UIColor = UIColor.greenColor()
    /// 加号？
    @IBInspectable var isAddButton: Bool = true
    
    override func drawRect(rect: CGRect) {
        // 1.圆形背景
        let path = UIBezierPath(ovalInRect: rect);
        fillColor.setFill()
        path.fill()
        
        let assistWidth: CGFloat = 0.5
        let plusHieght: CGFloat = 3.0
        let plusWidth: CGFloat  = min(bounds.width, bounds.height) * 0.6
        // 2.横线
        let horizontalPath = UIBezierPath()
        horizontalPath.lineWidth = plusHieght
        horizontalPath.moveToPoint(CGPoint(x: bounds.width / 2 - plusWidth / 2 + assistWidth, y: bounds.height / 2 + assistWidth))
        horizontalPath.addLineToPoint(CGPoint(x: bounds.width / 2 + plusWidth / 2 + assistWidth, y: bounds.height / 2 + assistWidth))
        UIColor.whiteColor().setStroke()
        horizontalPath.stroke()
        
        // 3.竖线
        if isAddButton {
            let verticalRect: CGRect = CGRect(x: bounds.width / 2 - plusHieght / 2 + assistWidth, y: bounds.height / 2 - plusWidth / 2 + 0.5, width: plusHieght, height: plusWidth)
            let verticalPath = UIBezierPath(rect: verticalRect)
            UIColor.whiteColor().setFill()
            verticalPath.fill()
        }
    }
}
