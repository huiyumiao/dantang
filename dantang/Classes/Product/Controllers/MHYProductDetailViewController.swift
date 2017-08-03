//
//  MHYProductDetailViewController.swift
//  dantang
//
//  Created by 苗慧宇 on 06/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

class MHYProductDetailViewController: MHYBaseViewController, UIScrollViewDelegate, MHYProductDetailToolBarDelegate {
    
    var product: MHYProduct?
    
    var result: MHYSearchResult?
    
    var type = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private lazy var scrollView: MHYDetailScrollView = {
        let scrollView = MHYDetailScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var toolBarView: MHYProductDetailToolBar = {
        let toolBarView = Bundle.main.loadNibNamed(String(describing: MHYProductDetailToolBar.self), owner: nil, options: nil)?.last as! MHYProductDetailToolBar
        toolBarView.delegate = self
        return toolBarView
    }()
    
    // MARK: - MHYProductDetailToolBarDelegate
    func toolBarDidClickedTMALLButton() {
        let tmallVC = MHYTMALLViewController()
        tmallVC.title = "商品详情"
        tmallVC.product = product
        let nav = MHYNavigationViewController(rootViewController: tmallVC)
        present(nav, animated: true, completion: nil)
    }
    
    
    func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "GiftShare_icon_18x22_"), style: .plain, target: self, action: #selector(shareBarBtnItemClick))
        
        view.addSubview(toolBarView)
        view.addSubview(scrollView)
        
        scrollView.product = product
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(64)
            make.left.right.equalTo(view)
            make.bottom.equalTo(toolBarView.snp.top)
        }
        
        toolBarView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.height.equalTo(45)
        }
        
        scrollView.contentSize = CGSize(width: SCREENW, height: SCREENH - 64 - 45 + kMargin + 520)
    }
    
    func shareBarBtnItemClick() {
        
    }
    
    
    
    
    // MARK: - UIScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        var offsetY = scrollView.contentOffset.y
//        if offsetY >= 465 {
//            offsetY = CGFloat(465)
//            scrollView.contentOffset = CGPoint(x: 0, y: offsetY)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
