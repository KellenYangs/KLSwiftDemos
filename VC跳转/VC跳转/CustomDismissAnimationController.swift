//
//  CustomDismissAnimationController.swift
//  VC跳转
//
//  Created by bcmac3 on 16/5/30.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

class CustomDismissAnimationController: NSObject {

}

extension CustomDismissAnimationController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let finalFrameForVC = transitionContext.finalFrameForViewController(toVC)
        let containerView = transitionContext.containerView()
        toVC.view.frame = finalFrameForVC
        toVC.view.alpha = 0.5
        containerView?.addSubview(toVC.view)
        containerView?.sendSubviewToBack(toVC.view)
        
        let snapshotView = fromVC.view.snapshotViewAfterScreenUpdates(false)
        snapshotView.frame = fromVC.view.frame
        containerView?.addSubview(snapshotView)
        fromVC.view.removeFromSuperview()
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
                snapshotView.frame = CGRectInset(fromVC.view.frame, fromVC.view.frame.size.width / 2, fromVC.view.frame.size.height / 2)
                toVC.view.alpha = 1.0
            }) { (_) in
                snapshotView.removeFromSuperview()
                transitionContext.completeTransition(true)
        }
        
    }
}