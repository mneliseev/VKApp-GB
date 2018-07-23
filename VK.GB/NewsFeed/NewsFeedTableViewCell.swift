//
//  NewsFeedTableViewCell.swift
//  VK.GB
//
//  Created by Максим on 12.07.2018.
//  Copyright © 2018 MaksimEliseev. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var imageFriend: UIImageView!
    @IBOutlet weak var nameFriend: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var newsLikesCount: UILabel!
    @IBOutlet weak var newsRepostCount: UILabel!
    @IBOutlet weak var newsCommentCount: UILabel!
    @IBOutlet weak var newsViewCount: UILabel!
    
    
}
