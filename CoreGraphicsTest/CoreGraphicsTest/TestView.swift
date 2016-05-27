//
//  TestView.swift
//  CoreGraphicsTest
//
//  Created by bcmac3 on 16/5/27.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

@IBDesignable
class TestView: UIView {

    lazy var textLabel: UILabel = {
        let l: UILabel = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 10))
        l.text = "KellenYangs"
        return l
    }()
    
    var i: Int = 0
    
    override func drawRect(rect: CGRect) {
        
        let ovalPath = UIBezierPath(roundedRect: rect, byRoundingCorners: .AllCorners, cornerRadii: CGSizeMake(10.0, 10.0))
        ovalPath.addClip()
        
        let path = UIBezierPath(rect: rect)
        UIColor.redColor().setFill()
        path.fill()
        
        textLabel.drawTextInRect(textLabel.frame)
//        addSubview(textLabel)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        i += 1
        textLabel.text = "kellenyangs\(i)"
        setNeedsDisplay()
    }


}
