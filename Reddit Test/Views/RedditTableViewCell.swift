//
//  RedditTableViewCell.swift
//  Reddit Test
//
//  Created by Steven on 8/26/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

class RedditTableViewCell: UITableViewCell {

    @IBOutlet weak var subredditLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var upvoteLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(post: Post) {
        subredditLabel.text = post.subRedditCellTitle
        usernameLabel.text = post.userCellTitle
        titleLabel.text = post.title
        messageLabel.text = post.summary
        upvoteLabel.text = post.upvote.intToString
        commentLabel.text = post.comments.intToString
    }
}
