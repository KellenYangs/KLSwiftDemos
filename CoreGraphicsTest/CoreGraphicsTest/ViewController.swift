//
//  ViewController.swift
//  CoreGraphicsTest
//
//  Created by bcmac3 on 16/5/26.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        counterLabel.text = "\(counterView.counter)"
    }

    @IBAction func btnPushButton(sender: PushButtonView) {
        if sender.isAddButton {
            if counterView.counter < NoOfGlasses {
                counterView.counter += 1
            }
        } else {
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
        }
        counterLabel.text = "\(counterView.counter)"
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

