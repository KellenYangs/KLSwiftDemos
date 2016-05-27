//
//  GraphView.swift
//  CoreGraphicsTest
//
//  Created by bcmac3 on 16/5/26.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView {
    
    @IBInspectable var startColor: UIColor = UIColor.redColor()
    @IBInspectable var endColor: UIColor = UIColor.greenColor()
    var graphPoints: [Int] = [4, 2, 6, 4, 5, 8, 3]
    
    override func drawRect(rect: CGRect) {
        
        // 1.绘制圆角
        let width = rect.width
        let height = rect.height
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .AllCorners, cornerRadii: CGSizeMake(8.0, 8.0))
        path.addClip()
        
        let context = UIGraphicsGetCurrentContext()
        
        // 2.渐变的背景颜色
        let colors = [startColor.CGColor, endColor.CGColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        // 渐变对象
        let gradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)

        var startPoint = CGPointZero
        var endPoint = CGPoint(x: 0, y: bounds.height)
        
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, .DrawsAfterEndLocation)
        
        // 3.绘制图表
        
        let margin: CGFloat = 20.0
        let columnXPoint = { (column: Int) -> CGFloat in
            let spacer = (width - margin * 2 - 4) / CGFloat((self.graphPoints.count - 1))
            var x: CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        
        let topBorder: CGFloat = 60
        let bottomBorder: CGFloat = 50
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.maxElement()
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            var y: CGFloat = CGFloat(graphPoint) / CGFloat(maxValue!) * graphHeight
            y = graphHeight + topBorder - y
            return y
        }
        
        UIColor.whiteColor().setFill()
        UIColor.whiteColor().setStroke()
        
        let graphPath = UIBezierPath()
        graphPath.moveToPoint(CGPoint(x: columnXPoint(0),
        y: columnYPoint(graphPoints[0])))
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x:columnXPoint(i),
                                    y:columnYPoint(graphPoints[i]))
            graphPath.addLineToPoint(nextPoint)
        }
//        graphPath.stroke()
        
        // 4.图表内部渐变色
        CGContextSaveGState(context)
        
        let clippingPath = graphPath.copy() as! UIBezierPath
        clippingPath.addLineToPoint(CGPoint(
            x: columnXPoint(graphPoints.count - 1),
            y:height))
        clippingPath.addLineToPoint(CGPoint(x: columnXPoint(0), y: height))
        clippingPath.closePath()
        clippingPath.addClip()
        
        let highestYPoint = columnYPoint(maxValue!)
        startPoint = CGPoint(x: margin, y: highestYPoint)
        endPoint = CGPoint(x: margin, y: bounds.height)
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, .DrawsAfterEndLocation)
        
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        // 5.点
        // 将当前图形状态推出堆栈
        CGContextRestoreGState(context)
        for i in 0..<graphPoints.count {
            var point = CGPoint(x:columnXPoint(i), y:columnYPoint(graphPoints[i]))
            point.x -= 4.0 / 2
            point.y -= 4.0 / 2
            let circle = UIBezierPath(ovalInRect:
                CGRect(origin: point,
                    size: CGSize(width: 4.0, height: 4.0)))
            circle.fill()
        }
        // 将当前图形状态推入堆栈，避免之后的操作改变里面的内容
        CGContextSaveGState(context)
        
        // 6.画线
        let linePath = UIBezierPath()
        // topLine
        linePath.moveToPoint(CGPoint(x: margin, y: topBorder))
        linePath.addLineToPoint(CGPoint(x: width - margin, y: topBorder))
        // centerLine
        linePath.moveToPoint(CGPoint(x:margin,
            y: graphHeight/2 + topBorder))
        linePath.addLineToPoint(CGPoint(x:width - margin,
            y:graphHeight/2 + topBorder))
        // bottomLine
        linePath.moveToPoint(CGPoint(x:margin,
            y:height - bottomBorder))
        linePath.addLineToPoint(CGPoint(x:width - margin,
            y:height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: 0.3)
        color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
        
    }

}


















