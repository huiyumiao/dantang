//
//  MHYDetailScrollView.swift
//  dantang
//
//  Created by 苗慧宇 on 06/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

class MHYDetailScrollView: UIScrollView {

    var product: MHYProduct? {
        didSet {
            topScrollView.product = product
            bottomScrollView.product = product
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // 顶部滚动视图
    private lazy var topScrollView: MHYProductDetailTopView = {
        let topScrollView = MHYProductDetailTopView()
        topScrollView.backgroundColor = UIColor.white
        return topScrollView
    }()
    
    private lazy var bottomScrollView: MHYProductDetailBottomView = {
        let bottomScrollView = MHYProductDetailBottomView()
        bottomScrollView.backgroundColor = UIColor.white
        return bottomScrollView
    }()
    
    func setupUI() {
        
        addSubview(topScrollView)
        addSubview(bottomScrollView)
        
        topScrollView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self)
            make.size.equalTo(CGSize(width: SCREENW, height: 520))
        }
        
        bottomScrollView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(topScrollView.snp.bottom).offset(kMargin)
            make.size.equalTo(CGSize(width: SCREENW, height: SCREENH - 64 - 45))
        }
    }
}
