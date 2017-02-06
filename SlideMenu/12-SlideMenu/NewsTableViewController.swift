//
//  NewsTableViewController.swift
//  12-SlideMenu
//
//  Created by bcmac3 on 16/7/27.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController, MenuTransitionManagerDelegate {

    let menuTransitionManager = MenuTransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Everyday Moments"
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.backgroundColor = UIColor(red:0.062, green:0.062, blue:0.07, alpha:1)

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let menuTableViewController = segue.destinationViewController as! MenuTableViewController
        menuTableViewController.currentItem = self.title!
        menuTableViewController.transitioningDelegate = menuTransitionManager
        menuTransitionManager.delegate = self
   
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NewsTableViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        
        if indexPath.row == 0 {
            cell.postImgv.image = UIImage(named: "1")
            cell.postTitle.text = "Love mountain."
            cell.postAuthor.text = "Allen Wang"
            cell.authorImgv.image = UIImage(named: "a")
            
        } else if indexPath.row == 1 {
            cell.postImgv.image = UIImage(named: "2")
            cell.postTitle.text = "New graphic design - LIVE FREE"
            cell.postAuthor.text = "Cole"
            cell.authorImgv.image = UIImage(named: "b")
            
        } else if indexPath.row == 2 {
            cell.postImgv.image = UIImage(named: "3")
            cell.postTitle.text = "Summer sand"
            cell.postAuthor.text = "Daniel Hooper"
            cell.authorImgv.image = UIImage(named: "c")
            
        } else {
            cell.postImgv.image = UIImage(named: "4")
            cell.postTitle.text = "Seeking for signal"
            cell.postAuthor.text = "Noby-Wan Kenobi"
            cell.authorImgv.image = UIImage(named: "d")
            
        }
        
        return cell
    }
   

}