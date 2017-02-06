//
//  KLBlurView.swift
//  KLBlurViewTest
//
//  Created by bcmac3 on 16/7/27.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

class KLBlurView: UIVisualEffectView {

    var blurProgress: Float = 0.0 {
        didSet {
            self.layer.timeOffset = Double(blurProgress);
        }
    }
    
    private var effectToRecover: UIVisualEffect?
    private var blurProgressToRecover: Float = 0.0
    private var suspended: Bool = false
    private var animationStopped: Bool = false
    private var observer_resign: AnyObject?
    private var observer_active: AnyObject?
    
    private func updateBlur() {
        if (self.effect == nil) && (effectToRecover == nil) { return }
        
        let TempEffect: UIVisualEffect = ((effectToRecover != nil) ? effectToRecover : self.effect)!
        self.effect = nil
        
        UIView.animateWithDuration(1.0, animations: {
            self.animationStopped = false
            self.effect = TempEffect
            }) { (_) in
                self.stopAnimation()
        }
        
        self.layer.speed = 0.0
        self.layer.timeOffset = Double(blurProgress)
    }
    
    private func stopAnimation() {
        if !self.animationStopped {
            self.animationStopped = true
            self.layer.speed = 1.0;
            self.layer.timeOffset = 0.0;
            blurProgressToRecover = blurProgress;
            blurProgress = 0.0;
            effectToRecover = self.effect;
            self.effect = nil;
        }
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        updateBlur()
        
        if observer_resign != nil {
           NSNotificationCenter.defaultCenter().removeObserver(self.observer_resign!, name: UIApplicationWillResignActiveNotification, object: nil)
            observer_resign = nil
        }
        
        if  observer_active != nil {
            NSNotificationCenter.defaultCenter().removeObserver(self.observer_active!, name: UIApplicationDidBecomeActiveNotification, object: nil)
            observer_active = nil
        }
        
        if self.window != nil {
            blurProgressToRecover = blurProgress
            blurProgress = 0
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(30 * NSEC_PER_MSEC)), dispatch_get_main_queue(), {
                self.blurProgress = self.blurProgressToRecover
            })
            
            observer_resign = NSNotificationCenter.defaultCenter().addObserverForName(UIApplicationWillResignActiveNotification, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { (_) in
                self.suspended = true
                self.stopAnimation()
            })
            
            observer_active = NSNotificationCenter.defaultCenter().addObserverForName(UIApplicationDidBecomeActiveNotification, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { (_) in
                if !self.suspended { return }
                self.suspended = false
                self.updateBlur()
                self.effectToRecover = nil
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_MSEC)), dispatch_get_main_queue(), { 
                    self.blurProgress = self.blurProgressToRecover;
                    self.blurProgressToRecover = 0.0;
                })
            })
        }
    }
}
