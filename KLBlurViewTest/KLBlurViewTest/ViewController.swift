//
//  ViewController.swift
//  KLBlurViewTest
//
//  Created by bcmac3 on 16/7/27.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var blurView: KLBlurView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.blurProgress = 0.2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func radiusChange(sender: UISlider) {
        blurView.blurProgress = sender.value
    }

    @IBAction func pan(sender: UIPanGestureRecognizer) {
        if ((sender.state == .Began) || (sender.state == .Changed)) {
            let moveP = sender.translationInView(view)
            blurView.transform = CGAffineTransformMakeTranslation(moveP.x, moveP.y)
        } else {
            blurView.transform = CGAffineTransformIdentity
        }
        
    }
    

}

