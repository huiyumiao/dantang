//
//  MHYCollectionViewCell.swift
//  dantang
//
//  Created by 苗慧宇 on 05/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

protocol MHYCollectionViewCellDelegate: NSObjectProtocol {
    func collectionViewCellDidClickedLikeButton(button: UIButton)
}

class MHYCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!

    @IBOutlet weak var likeBtn: UIButton!
    
    @IBOutlet weak var placeholderBtn: UIButton!
    
    weak var delegate: MHYCollectionViewCellDelegate?
    
    var result: MHYSearchResult? {
        didSet {
            let url = result!.cover_image_url!
            productImageView.kf.setImage(with: URL(string: url)!, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, url) in
                
                self.placeholderBtn.isHidden = true
            }
            likeBtn.setTitle(" " + String(result!.favorites_count!) + " ", for: .normal)
            titleLabel.text = result!.name
            priceLabel.text = "￥" + String(result!.price!)
        }
    }
    
    var product: MHYProduct? {
        didSet {
            let url = product!.cover_image_url!
            productImageView.kf.setImage(with: URL(string: url)!, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, url) in
                
                self.placeholderBtn.isHidden = true
            }
            likeBtn.setTitle(" " + String(product!.favorites_count!) + " ", for: .normal)
            titleLabel.text = product!.name
            priceLabel.text = "￥" + String(product!.price!)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 3
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 0.5
    }

    @IBAction func likeBtnClicked(_ sender: UIButton) {
        delegate?.collectionViewCellDidClickedLikeButton(button: sender)
    }
}
