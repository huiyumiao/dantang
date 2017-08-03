//
//  MHYDanTangViewController.swift
//  dantang
//
//  Created by 苗慧宇 on 02/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

class MHYDanTangViewController: MHYBaseViewController {
    
    var channels = [MHYChannel]()
    
    // 标签
    weak var titleView = UIView()
    
    // 底部红色指示器
    weak var indicatorView = UIView()
    
    // 按钮容器
    weak var contentView = UIScrollView()
    
    // 当前选中的按钮
    weak var selectedButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        
        weak var weakSelf = self
        // 获取首页顶部选择数据
        MHYNetworkTool.sharedNetworkTool.loadHomeTopData { (channels) in
            for channel in channels {
                let vc = MHYTopicTableViewController()
                vc.title = channel.name
                vc.type = channel.id!
                weakSelf!.addChildViewController(vc)
            }
            // 设置顶部标签栏
            weakSelf!.setupTitlesView()
            // 底部的scrollview
            weakSelf!.setupContentView()
        }
    }
    
    // MARK: - 初始化子控制器
    func setupChildViewControllers() {
        for channel in channels {
            let vc = MHYTopicTableViewController()
            vc.title = channel.name
            addChildViewController(vc)
        }
    }
    
    // MARK: - 顶部标签栏
    func setupTitlesView() {
        // 顶部背景
        let bgView = UIView()
        bgView.frame = CGRect(x: 0, y: kTitlesViewY, width: SCREENW, height: kTitlesViewH)
        view.addSubview(bgView)
        // 标签
        let titleView = UIView()
        titleView.backgroundColor = MHYGlobalColor()
        titleView.frame = CGRect(x: 0, y: 0, width: SCREENW - kTitlesViewH, height: kTitlesViewH)
        bgView.addSubview(titleView)
        self.titleView = titleView
        // 底部红色指示器
        let indicatorView = UIView()
        indicatorView.backgroundColor = MHYGlobalRedColor()
        indicatorView.height = kIndicatorViewH
        indicatorView.y = kTitlesViewH - kIndicatorViewH
        indicatorView.tag = -1
        self.indicatorView = indicatorView
        
        // 选择按钮
        let arrowButton = UIButton()
        arrowButton.frame = CGRect(x: SCREENW - kTitlesViewH, y: 0, width: kTitlesViewH, height: kTitlesViewH)
        arrowButton.setImage(UIImage.init(named: "arrow_index_up_8x4_"), for: .normal)
        arrowButton.addTarget(self, action: #selector(arrowButtonClick), for: .touchUpInside)
        arrowButton.backgroundColor = MHYGlobalColor()
        bgView.addSubview(arrowButton)
        
        // 内部子标签
        let count = childViewControllers.count
        let width = titleView.width / CGFloat(count)
        let height = titleView.height
        
        for index in 0..<count {
            let button = UIButton()
            button.height = height
            button.width = width
            button.x = CGFloat(index) * width
            button.tag = index
            let vc = childViewControllers[index]
            button.titleLabel!.font = UIFont.systemFont(ofSize: 14)
            button.setTitle(vc.title, for: .normal)
            button.setTitleColor(UIColor.gray, for: .normal)
            button.setTitleColor(MHYGlobalRedColor(), for: .disabled)
            button.addTarget(self, action: #selector(titlesClick(button:)), for: .touchUpInside)
            titleView.addSubview(button)
            // 默认点击了第一个按钮
            if index == 0 {
                button.isEnabled = false
                selectedButton = button
                //让按钮内部的Label根据文字来计算内容
                button.titleLabel?.sizeToFit()
                indicatorView.width = button.titleLabel!.width
                indicatorView.centerX = button.centerX
            }
        }
        // 底部红色指示器
        titleView.addSubview(indicatorView)
    }
    
    // 箭头按钮点击
    func arrowButtonClick(button: UIButton) {
        UIView.animate(withDuration: kAnimationDuration) {
            button.imageView?.transform = button.imageView!.transform.rotated(by: .pi)
        }
    }
    
    // 标签上的按钮点击
    func titlesClick(button: UIButton) {
        // 修改按钮状态
        selectedButton!.isEnabled = true
        button.isEnabled = false
        selectedButton = button
        // 让标签执行动画
        UIView.animate(withDuration: kAnimationDuration) {
            self.indicatorView!.width = self.selectedButton!.titleLabel!.width
            self.indicatorView!.centerX = self.selectedButton!.centerX
        }
        //滚动,切换子控制器
        var offset = contentView!.contentOffset
        offset.x = CGFloat(button.tag) * contentView!.width
        contentView!.setContentOffset(offset, animated: true)
    }
    
    // MARK: - 底部的scrollview
    func setupContentView() {
        automaticallyAdjustsScrollViewInsets = false
        
        let contentView = UIScrollView()
        contentView.frame = view.bounds
        contentView.delegate = self
        contentView.contentSize = CGSize(width: contentView.width * CGFloat(childViewControllers.count), height: 0)
        contentView.isPagingEnabled = true
        view.insertSubview(contentView, at: 0)
        self.contentView = contentView
        
        // 添加第一个控制器的view
        scrollViewDidEndScrollingAnimation(contentView)
    }
    
    // MARK: - 设置导航栏
    func setupNav() {
        view.backgroundColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "Feed_SearchBtn_18x18_"), style: .plain, target: self, action: #selector(dantangRightBarBtnClicked))
    }
    
    func dantangRightBarBtnClicked() {
        let searchBarVC = MHYSearchBarViewController()
        navigationController?.pushViewController(searchBarVC, animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - UIScrollViewDelegate
extension MHYDanTangViewController: UIScrollViewDelegate {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        // 添加子控制器的 view
        // 当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        
        // 当前子控制器
        let vc = childViewControllers[index]
        vc.view.x = scrollView.contentOffset.x
        vc.view.y = 0  // 设置控制器的y值为0(默认为20)
        //设置控制器的view的height值为整个屏幕的高度（默认是比屏幕少20）
        vc.view.height = scrollView.height
        scrollView.addSubview(vc.view)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        let button = titleView!.subviews[index] as! UIButton
        titlesClick(button: button)
    }
}
