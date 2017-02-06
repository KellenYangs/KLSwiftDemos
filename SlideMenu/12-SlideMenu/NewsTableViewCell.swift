//
//  NewsTableViewCell.swift
//  12-SlideMenu
//
//  Created by bcmac3 on 16/7/27.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var postImgv: UIImageView!
    @IBOutlet weak var authorImgv: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        authorImgv.layer.cornerRadius = authorImgv.frame.width / 2
        authorImgv.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
