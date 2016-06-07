//
//  CustomPresentAnimationController.swift
//  VC跳转
//
//  Created by bcmac3 on 16/5/30.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

class CustomPresentAnimationController: NSObject {

    
    
    
}

// MARK: -- UIViewControllerAnimatedTransitioning
extension CustomPresentAnimationController: UIViewControllerAnimatedTransitioning {
    /** 动画时长 */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let finalFrameForVC = transitionContext.finalFrameForViewController(toVC)
        let containerView = transitionContext.containerView()
        let bounds = UIScreen.mainScreen().bounds
        toVC.view.frame = CGRectOffset(finalFrameForVC, 0, -bounds.size.height)
        containerView?.addSubview(toVC.view)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .CurveLinear, animations: { 
                fromVC.view.alpha = 0.5
                toVC.view.frame = finalFrameForVC
            }) { (finished) in
                transitionContext.completeTransition(true)
                fromVC.view.alpha = 1.0
        }
        
        
    }
}
