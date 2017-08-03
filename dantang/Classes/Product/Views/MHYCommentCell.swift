//
//  MHYCommentCell.swift
//  dantang
//
//  Created by 苗慧宇 on 06/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

class MHYCommentCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    

    var comment: MHYComment? {
        didSet {
            let user = comment?.user
            if let avatarUrl = user?.avatar_url {
                avatarImageView.kf.setImage(with: URL(string: avatarUrl))
            }
            nameLabel.text = user?.nickname
            contentLabel.text = comment?.content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
