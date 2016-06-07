//
//  ViewController.swift
//  Pac_Animation
//
//  Created by bcmac3 on 16/5/31.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var indicator: PacmanIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        indicator = PacmanIndicatorView(frame: CGRectMake(0, 0, 200, 30))
        indicator.center = self.view.center
        indicator.startAnimating()
        self.view.addSubview(indicator)

        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //开始和停止动画
        if !indicator.hidden {
            indicator.stopAnimating()
        } else {
            indicator.startAnimating()
        }
        
        //改变颜色
        indicator.pacmanColor = UIColor.redColor()
        indicator.beansColor = UIColor.greenColor()

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

