
//
//  MHYDetailChoiceButtonView.swift
//  dantang
//
//  Created by 苗慧宇 on 06/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

protocol MHYDetailChoiceButtonViewDegegate: NSObjectProtocol {
    // 图文介绍按钮点击
    func choiceIntroduceButtonClick()
    // 评论按钮点击
    func choiceCommentButtonClick()
}

class MHYDetailChoiceButtonView: UIView {
    
    weak var delegate: MHYDetailChoiceButtonViewDegegate?
    
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var lineViewLeadingConstraint: NSLayoutConstraint!
    
    @IBAction func introduceBtnClicked(_ sender: UIButton) {
        UIView.animate(withDuration: kAnimationDuration) {
            self.lineView.x = 0
        }
        delegate?.choiceIntroduceButtonClick()
    }
    
    @IBAction func commentBtnClicked(_ sender: UIButton) {
        UIView.animate(withDuration: kAnimationDuration) {
            self.lineView.x = SCREENW * 0.5
        }
        delegate?.choiceCommentButtonClick()
    }
    
    class func choiceButtonView() -> MHYDetailChoiceButtonView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)!.last as! MHYDetailChoiceButtonView
    }

}
