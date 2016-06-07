//
//  PacmanIndicatorView.swift
//  Pac_Animation
//
//  Created by bcmac3 on 16/5/31.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

class PacmanIndicatorView: UIView {

    var pacmanColor: UIColor! {
        didSet {
            pacmanLayer.fillColor = pacmanColor.CGColor
        }
    }
    
    var beansColor: UIColor! {
        didSet {
            for bean in beanLayers {
                bean.backgroundColor = beansColor.CGColor
            }
        }
    }
    
    /// 这个参数可以控制吃豆人张开嘴，0~1
    var openMouthProgress: CGFloat! {
        didSet {
            openMouth()
        }
    }
    
    private var progress: CGFloat = 0
    private var dispalyLink: CADisplayLink!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.addSublayer(pacmanLayer)
        pacmanLayer.addSublayer(eyeLayer)
        
        backgroundColor = UIColor.clearColor()
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        //使用cos函数保证ratio在0~1之间循环
        let ratio: CGFloat = abs(cos(progress))
        progress += 0.1
        
        let path = UIBezierPath()
        let center = CGPointMake(CGRectGetMidX(pacmanLayer.bounds), CGRectGetMidY(pacmanLayer.bounds))
        path.moveToPoint(center)
        path.addArcWithCenter(CGPointMake(CGRectGetMidX(pacmanLayer.bounds), CGRectGetMidY(pacmanLayer.bounds)), radius: pacmanLayer.bounds.height / 2.0, startAngle:CGFloat(M_PI_4) * ratio, endAngle: -CGFloat(M_PI_4) * ratio, clockwise: true)
        path.closePath()
        pacmanLayer.path = path.CGPath
        
        //豆子的移动
        for layer in beanLayers {
            layer.position.x -= ((CGRectGetWidth(pacmanLayer.bounds) / 1.5) / (CGFloat(M_PI) / 0.1))
        }
        
        //删除到达吃豆人的豆子
        var firstBean = beanLayers.first
        if firstBean!.position.x <= pacmanLayer.position.x && ratio <= 0.05 {
            beanLayers.removeAtIndex(0)
            firstBean!.removeFromSuperlayer()
            firstBean = nil
        }
        
        //在最后添加新的豆子
        let lastBean = beanLayers.last!
        if lastBean.position.x <= CGRectGetWidth(self.bounds) {
            let newBean = CALayer()
            newBean.bounds = lastBean.bounds
            newBean.position = CGPointMake(lastBean.position.x + (CGRectGetWidth(pacmanLayer.bounds) / 1.5), lastBean.position.y)
            newBean.backgroundColor = lastBean.backgroundColor
            newBean.cornerRadius = lastBean.cornerRadius
            
            self.layer.insertSublayer(newBean, below: pacmanLayer)
            beanLayers.append(newBean)
        }
        
    }
    
    //初始化 beans 的位置
    func resetBeans() {
        for i in 0..<beanLayers.count {
            let position = CGPointMake(pacmanLayer.position.x + (CGRectGetWidth(pacmanLayer.bounds) / 1.5) * CGFloat(i), pacmanLayer.position.y)
            let beanLayer = beanLayers[i]
            
            beanLayer.position = position
        }
        
    }
    
    private func openMouth() {
        let path = UIBezierPath()
        let center = CGPointMake(CGRectGetMidX(pacmanLayer.bounds), CGRectGetMidY(pacmanLayer.bounds))
        path.moveToPoint(center)
        path.addArcWithCenter(CGPointMake(CGRectGetMidX(pacmanLayer.bounds), CGRectGetMidY(pacmanLayer.bounds)), radius: pacmanLayer.bounds.width / 2.0, startAngle:CGFloat(M_PI_4) * openMouthProgress, endAngle: -CGFloat(M_PI_4) * openMouthProgress, clockwise: true)
        path.closePath()
        pacmanLayer.path = path.CGPath
    }
    
    func startAnimating() {
        if dispalyLink == nil {
            dispalyLink = CADisplayLink(target: self, selector: #selector(UIView.drawRect(_:)))
            dispalyLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        }
    }
    
    func stopAnimating() {
        if dispalyLink != nil {
            dispalyLink.invalidate()
            dispalyLink = nil
            
            progress = 0
            drawRect(self.frame)
            
            resetBeans()
        }
    }
    
    // MARK: -- 懒加载
    /// 吃豆人主体
    private lazy var pacmanLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.bounds = CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))
        layer.position = CGPointMake(CGRectGetWidth(self.frame) * 0.5, CGRectGetMidY(self.frame))
        layer.fillColor = UIColor(red: 234/255.0, green: 90/255.0, blue: 97/255.0, alpha: 1).CGColor
        return layer
    }()
    /// 吃豆人眼球
    private lazy var eyeLayer: CALayer = {
        let layer = CALayer()
        layer.bounds = CGRectMake(0, 0, CGRectGetWidth(self.pacmanLayer.bounds)*0.1, CGRectGetWidth(self.pacmanLayer.frame)*0.1)
        layer.position = CGPointMake(CGRectGetWidth(self.pacmanLayer.frame) * 0.6, CGRectGetHeight(self.pacmanLayer.frame) * 0.2)
        layer.backgroundColor = UIColor.blackColor().CGColor
        layer.cornerRadius = CGRectGetWidth(layer.bounds) / 2.0
        return layer
    }()
    /// 豆子
    private lazy var beanLayers: [CALayer] = {
        var lean = [CALayer]()
        let count = Int((CGRectGetWidth(self.frame) - self.pacmanLayer.position.x) / (CGRectGetWidth(self.pacmanLayer.bounds) / 1.5)) + 1
        for i in 0..<count {
            let position = CGPointMake(self.pacmanLayer.position.x + (CGRectGetWidth(self.pacmanLayer.bounds) / 1.5) * CGFloat(i), self.pacmanLayer.position.y)
            let beanLayer = CALayer()
            beanLayer.bounds = CGRectMake(0, 0, CGRectGetWidth(self.pacmanLayer.bounds) * 0.2, CGRectGetHeight(self.pacmanLayer.bounds) * 0.2)
            beanLayer.position = position
            beanLayer.backgroundColor = UIColor(red: 253/255.0, green: 236/255.0, blue: 155/255.0, alpha: 1).CGColor
            beanLayer.cornerRadius = CGRectGetWidth(beanLayer.bounds) / 2.0
            self.layer.insertSublayer(beanLayer, below: self.pacmanLayer)
            lean.append(beanLayer)
        }
        return lean
    }()
    
    
}
