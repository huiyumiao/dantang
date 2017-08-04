//
//  MHYProductViewController.swift
//  dantang
//
//  Created by 苗慧宇 on 02/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit
import SVProgressHUD

let collectionCellID = "MHYCollectionViewCell"

class MHYProductViewController: MHYBaseViewController, MHYCollectionViewCellDelegate {
    
    var products = [MHYProduct]()
    
    weak var collectionView: UICollectionView?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        
        loadProducts()
    }
    
    func loadProducts() {
        weak var weakSelf = self
        MHYNetworkTool.sharedNetworkTool.loadProductData { (products) in
            if #available(iOS 10.0, *) {
                weakSelf!.collectionView!.refreshControl!.endRefreshing()
            } else {
                // Fallback on earlier versions
            }
            weakSelf!.products = products
            weakSelf!.collectionView!.reloadData()
        }
    }
    
    private func setupCollectionView() {
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        
        if #available(iOS 10.0, *) {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(loadProducts), for: .valueChanged)
            collectionView.refreshControl = refreshControl
        } else {
            // Fallback on earlier versions
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = view.backgroundColor
        
        let nib = UINib(nibName: String(describing: MHYCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: collectionCellID)
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    func collectionViewCellDidClickedLikeButton(button: UIButton) {
        SVProgressHUD.show(withStatus: "请先登录")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MHYProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! MHYCollectionViewCell
        cell.product = products[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = MHYProductDetailViewController()
        detailVC.title = "商品详情"
        detailVC.product = products[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (SCREENW - 24) / 2
        let height: CGFloat = 245
        return CGSize(width: width, height: height)
    }
    
    // 列距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    // 行距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    // 每个 section 的 inset
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 8, 8, 8)
    }
}
