//
//  MHYHomeCell.swift
//  dantang
//
//  Created by 苗慧宇 on 02/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit
import Kingfisher

protocol MHYHomeCellDelegate: NSObjectProtocol {
    func homeCellDidClickedFavoriteButton(button: UIButton)
}

let homeCellID = "homeCellID"

class MHYHomeCell: UITableViewCell {
    
    weak var delegate: MHYHomeCellDelegate?

    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var favoriteBtn: UIButton!
    
    @IBOutlet weak var placeHolderBtn: UIButton!
    
    var homeItem: MHYHomeItem? {
        didSet {
            let url = homeItem!.cover_image_url
            bgImageView.kf.setImage(with: URL(string: url!)!,
                                    placeholder: nil,
                                    options: nil,
                                    progressBlock: nil)
            { (image, error, cacheType, url) in
                self.placeHolderBtn.isHidden = true
            }
            titleLabel.text = homeItem!.title
            favoriteBtn.setTitle(" " + String(homeItem!.likes_count!) + " ", for: .normal)
        }
    }
    
    var topicItem: MHYPostModel? {
        didSet {
            let url = topicItem!.cover_image_url
            bgImageView.kf.setImage(with: URL(string: url!)!,
                                    placeholder: nil,
                                    options: nil,
                                    progressBlock: nil)
            { (image, error, cacheType, url) in
                self.placeHolderBtn.isHidden = true
            }
            titleLabel.text = topicItem!.title
            favoriteBtn.setTitle(" " + String(topicItem!.likes_count!) + " ", for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        favoriteBtn.layer.cornerRadius = favoriteBtn.height * 0.5
        favoriteBtn.layer.masksToBounds = true
        favoriteBtn.layer.rasterizationScale = UIScreen.main.scale
        favoriteBtn.layer.shouldRasterize = true
        bgImageView.layer.cornerRadius = kCornerRadius
        bgImageView.layer.masksToBounds = true
        bgImageView.layer.shouldRasterize = true
        bgImageView.layer.rasterizationScale = UIScreen.main.scale
    }

    @IBAction func favoriteBtnClicked(_ sender: UIButton) {
        delegate?.homeCellDidClickedFavoriteButton(button: sender)
    }
    
}
