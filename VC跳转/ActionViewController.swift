//
//  ActionViewController.swift
//  VC跳转
//
//  Created by bcmac3 on 16/5/30.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController {

    @IBAction func dismiss(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("create")
        view.backgroundColor = UIColor.whiteColor()
        
    }

    

}
