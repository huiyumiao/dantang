//
//  MHYProductDetailTopView.swift
//  dantang
//
//  Created by 苗慧宇 on 06/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit
import SnapKit

let detailCollectionViewCellID = "detailCollectionViewCellID"

class MHYProductDetailTopView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var imageURLs = [String]()

    var product: MHYProduct? {
        didSet {
            imageURLs = product!.image_urls!
            collectionView.reloadData()
            pageControl.numberOfPages = imageURLs.count
            titleLabel.text = product!.name
            priceLabel.text = "￥\(product!.price!)"
            describeLabel.text = product!.describe
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        addSubview(pageControl)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(describeLabel)
        
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(collectionView.snp.bottom).offset(-30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(5)
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-5)
            make.height.equalTo(30)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.right.equalTo(titleLabel)
            make.height.equalTo(25)
        }
        
        describeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.left.right.equalTo(priceLabel)
            make.bottom.equalTo(self).offset(-5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        return pageControl
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.gray
        return titleLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.numberOfLines = 0
        priceLabel.textColor = MHYGlobalRedColor()
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        return priceLabel
    }()
    
    private lazy var describeLabel: UILabel = {
        let describeLabel = UILabel()
        describeLabel.numberOfLines = 0
        describeLabel.textColor = MHYColor(r: 0, g: 0, b: 0, a: 0.6)
        describeLabel.font = UIFont.systemFont(ofSize: 15)
        return describeLabel
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: 375), collectionViewLayout: MHYLayout())
        
        let nib = UINib(nibName: String(describing: MHYDetailCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: detailCollectionViewCellID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    // MARK: - UICollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCollectionViewCellID, for: indexPath) as! MHYDetailCollectionViewCell
        
        let url = imageURLs[indexPath.item]
        cell.bgImageView.kf.setImage(with: URL(string: url)!, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, url) in
            cell.placeholderBtn.isHidden = true
        }
        
        return cell
    }
    
    // MARK: - UICollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let page = offsetX / scrollView.width
        pageControl.currentPage = Int(page + 0.5)
    }
}

private class MHYLayout: UICollectionViewFlowLayout {
    fileprivate override func prepare() {
        // 设置 layout 布局
        itemSize                = CGSize(width: SCREENW, height: 375)
        scrollDirection         = .horizontal
        minimumLineSpacing      = 0
        minimumInteritemSpacing = 0
        
        // 设置 contentView 属性
        collectionView?.showsVerticalScrollIndicator   = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces                        = false
        collectionView?.isPagingEnabled                = true
    }
}
