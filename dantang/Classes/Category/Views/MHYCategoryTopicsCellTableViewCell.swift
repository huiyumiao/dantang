
//
//  MHYCategoryTopicsCellTableViewCell.swift
//  dantang
//
//  Created by 苗慧宇 on 04/08/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

let TopicCollectionsCell = "MHYCategoryTopicsCellTableViewCell"

class MHYCategoryTopicsCellTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var showAllBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let imgViewMargin = 10
    let imgViewWidth  = 150
    let imgViewHeight = 70
    
    var topicListCloser: ((Int) -> ())?
    var showAllCloser: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        scrollView.showsHorizontalScrollIndicator = false
        titleLabel.text = "专题合集"
        showAllBtn.titleLabel?.text = "查看全部"
    }
    
    @IBAction func showAllAction(_ sender: UIButton) {
        if showAllCloser != nil {
            showAllCloser!()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func rowHeight() -> CGFloat {
        return 120
    }
    
    var topicCollections: [MHYTopicModel]? {
        didSet {
            let imgViewTotalWidth = (imgViewWidth + imgViewMargin) * (topicCollections?.count)! + imgViewMargin
            scrollView.contentSize = CGSize(width: imgViewTotalWidth, height: imgViewHeight)
            addSubViewsToScrollView(topicCollections: topicCollections!)
        }
    }
    
    private func addSubViewsToScrollView(topicCollections: [MHYTopicModel]) {
        for element in (topicCollections.enumerated()) {
            let frame = CGRect(x: imgViewMargin + element.offset * (imgViewMargin + imgViewWidth), y: 0, width: imgViewWidth, height: imgViewHeight)
            let backView = UIView(frame: frame)
            
            let placeHolderBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 31, height: 26))
            placeHolderBtn.setImage(#imageLiteral(resourceName: "PlaceHolderImage_small_31x26_"), for: .normal)
            
            let imgView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: imgViewWidth, height: imgViewHeight))
            imgView.tag = element.offset
            imgView.isUserInteractionEnabled = true
            let recognizer = UITapGestureRecognizer(target:self, action:#selector(loadSpecificTopic(_:)))
            imgView.addGestureRecognizer(recognizer)
            imgView.layer.cornerRadius = 3
            imgView.layer.masksToBounds = true
            
            placeHolderBtn.center = CGPoint(x: imgView.centerX, y: imgView.centerY)
            backView.addSubview(placeHolderBtn)
            backView.addSubview(imgView)
            
            imgView.kf.setImage(with: URL(string: element.element.banner_image_url!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, _, _, _) in
                if image != nil {
                    placeHolderBtn.isHidden = true
                }
            })
            
            scrollView.addSubview(backView)
        }
    }
    
    @objc private func loadSpecificTopic(_ recognizer: UITapGestureRecognizer) {
        let imgView = recognizer.view as! UIImageView
        
        let topic = topicCollections?[imgView.tag]
        
        if topicListCloser != nil {
            topicListCloser!((topic?.id)!)
        }
    }
}
