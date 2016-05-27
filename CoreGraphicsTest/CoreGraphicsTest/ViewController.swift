//
//  ViewController.swift
//  CoreGraphicsTest
//
//  Created by bcmac3 on 16/5/26.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var graphView: GraphView!
    
    @IBOutlet weak var averageWaterDrunk: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    var isGraphViewShowing: Bool = false
    
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

    @IBAction func containerViewTap(sender: UITapGestureRecognizer) {
        if isGraphViewShowing {
            UIView.transitionFromView(graphView, toView: counterView, duration: 1.0, options: [.TransitionFlipFromLeft, .ShowHideTransitionViews], completion: nil)
        } else {
            UIView.transitionFromView(counterView, toView: graphView, duration: 1.0, options: [.TransitionFlipFromRight, .ShowHideTransitionViews], completion: nil)
            setupGraphDisplay()
        }
        isGraphViewShowing = !isGraphViewShowing
    }
    
    func setupGraphDisplay() {
        graphView.graphPoints[graphView.graphPoints.count - 1] = counterView.counter
        graphView.setNeedsDisplay()
        
        maxLabel.text = "\(graphView.graphPoints.maxElement()!)"
        
        let average = graphView.graphPoints.reduce(0, combine: +) / graphView.graphPoints.count
        averageWaterDrunk.text = "\(average)"
        
        let calendar = NSCalendar.currentCalendar()
        let componentOptions: NSCalendarUnit = .Weekday
        let components = calendar.components(componentOptions, fromDate: NSDate())
        
        var weekday = components.weekday
        
        let days = ["一", "二", "三", "四", "五", "六", "七"]
        
        for i in (1...days.count).reverse()  {
            print("\(i) - \(weekday)")
            if let labelView = graphView.viewWithTag(i) as? UILabel {
                if weekday == 7 {
                    weekday = 0
                }
                labelView.text = days[weekday]
                weekday -= 1
                if weekday < 0 {
                    weekday = days.count - 1
                }
            }
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

