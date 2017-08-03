//
//  MHYProductDetailToolBar.swift
//  dantang
//
//  Created by 苗慧宇 on 07/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

protocol MHYProductDetailToolBarDelegate: NSObjectProtocol {
    func toolBarDidClickedTMALLButton()
}

class MHYProductDetailToolBar: UIView {

    weak var delegate: MHYProductDetailToolBarDelegate?
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var goTMBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        goTMBtn.layer.cornerRadius = 35 / 2
        likeBtn.layer.cornerRadius = 35 / 2
        likeBtn.layer.borderColor = MHYGlobalRedColor().cgColor
        likeBtn.layer.borderWidth = klineWidth
        likeBtn.setImage(UIImage(named: "content-details_like_16x16_"), for: .normal)
        likeBtn.setImage(UIImage(named: "content-details_like_selected_16x16_"), for: .selected)
    }

    @IBAction func likeBtnClicked(_ sender: UIButton) {
        print("请先登录")
    }
    
    @IBAction func goTMBtnClicked(_ sender: UIButton) {
        delegate?.toolBarDidClickedTMALLButton()
    }

}
