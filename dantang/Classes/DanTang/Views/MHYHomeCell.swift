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
    
    @IBOutlet weak var zeroLabel: UILabel!
    @IBOutlet weak var leftLineView: UIView!
    @IBOutlet weak var rightLineView: UIView!
    @IBOutlet weak var centerTitleLabel: UILabel!
    @IBOutlet weak var centerSubtitleLabel: UILabel!
    
    static func rowHeight() -> CGFloat {
        return 160
    }
    
    var homeItem: MHYHomeItem? {
        didSet {
            showCenterInfo(false)
            
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
    
    var postItem: MHYPostModel? {
        didSet {
            showCenterInfo(false)
            
            let url = postItem!.cover_image_url
            bgImageView.kf.setImage(with: URL(string: url!)!,
                                    placeholder: nil,
                                    options: nil,
                                    progressBlock: nil)
            { (image, error, cacheType, url) in
                self.placeHolderBtn.isHidden = true
            }
            titleLabel.text = postItem!.title
            favoriteBtn.setTitle(" " + String(postItem!.likes_count!) + " ", for: .normal)
        }
    }
    
    var topicItem: MHYTopicModel? {
        didSet {
            showCenterInfo(true)
            
            let url = topicItem!.cover_image_url
            bgImageView.kf.setImage(with: URL(string: url!)!,
                                    placeholder: nil,
                                    options: nil,
                                    progressBlock: nil)
            { (image, error, cacheType, url) in
                self.placeHolderBtn.isHidden = true
            }
            
            centerTitleLabel.text    = topicItem?.title
            centerSubtitleLabel.text = topicItem?.subtitle
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
    
    private func showCenterInfo(_ show: Bool) {
        if show {
            centerTitleLabel.isHidden    = false
            centerSubtitleLabel.isHidden = false
            zeroLabel.isHidden           = false
            leftLineView.isHidden        = false
            rightLineView.isHidden       = false
            
            titleLabel.isHidden  = true
            favoriteBtn.isHidden = true

        } else {
            centerTitleLabel.isHidden    = true
            centerSubtitleLabel.isHidden = true
            zeroLabel.isHidden           = true
            leftLineView.isHidden        = true
            rightLineView.isHidden       = true
            
            titleLabel.isHidden  = false
            favoriteBtn.isHidden = false
        }
    }
    
}
