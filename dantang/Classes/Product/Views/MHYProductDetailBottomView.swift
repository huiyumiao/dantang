//
//  MHYProductDetailBottomView.swift
//  dantang
//
//  Created by 苗慧宇 on 06/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

let commentCellID = "commentCellID"

class MHYProductDetailBottomView: UIView, UIWebViewDelegate, MHYDetailChoiceButtonViewDegegate, UITableViewDelegate, UITableViewDataSource {

    var comments = [MHYComment]()
    
    var product: MHYProduct? {
        didSet {
            weak var weakSelf = self
            MHYNetworkTool.sharedNetworkTool.loadProductDetailData(id: (product?.id)!) { (productDetail) in
                weakSelf!.choiceButtonView.commentBtn.setTitle("评论(\(productDetail.comments_count!))", for: .normal)
                weakSelf!.webView.loadHTMLString(productDetail.detail_html!, baseURL: nil)
            }
            
            MHYNetworkTool.sharedNetworkTool.loadProductDetailComments(id: (product?.id)!) { (comments) in
                weakSelf?.comments = comments
                weakSelf!.tableView.reloadData()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 添加顶部选择按钮 view（图文介绍，评论）
        addSubview(choiceButtonView)
        addSubview(tableView)
        addSubview(webView)
        
        choiceButtonView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: SCREENW, height: 44))
            make.top.equalTo(self)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(choiceButtonView.snp.bottom)
            make.left.bottom.right.equalTo(self)
        }
        
        webView.snp.makeConstraints { (make) in
            make.top.equalTo(choiceButtonView.snp.bottom)
            make.left.right.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - lazy var
    
    private lazy var webView: UIWebView = {
        let webView = UIWebView()
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .all
        webView.delegate = self
        return webView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 64
        let nib = UINib(nibName: String(describing: MHYCommentCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: commentCellID)
        return tableView
    }()
    
    private lazy var choiceButtonView: MHYDetailChoiceButtonView = {
        let choiceButtonView = MHYDetailChoiceButtonView.choiceButtonView()
        choiceButtonView.delegate = self
        return choiceButtonView
    }()
    
    // MARK: - MHYDetailChoiceButtonViewDegegate
    func choiceIntroduceButtonClick() {
        tableView.isHidden = true
        webView.isHidden = false
    }
    
    func choiceCommentButtonClick() {
        tableView.isHidden = false
        webView.isHidden = true
    }
    
    // MARK: - UIWebView Delegate
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show(withStatus: "加载中...")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    
    // MARK: - UITableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return choiceButtonView;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commentCellID, for: indexPath) as! MHYCommentCell
        cell.comment = comments[indexPath.row]
        
        return cell
    }
}
