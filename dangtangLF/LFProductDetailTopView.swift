//
//  LFProductDetailTopView.swift
//  dangtangLF
//
//  Created by jim on 17/2/2.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import SVProgressHUD

class LFProductDetailTopView: UIView {

    var collectionView: UICollectionView!
    var pageControl = UIPageControl()
    var titleLabel = UILabel()
    var priceLabel = UILabel()
    var describeLabel = UILabel()

    var imageURLs = [String]()
    
    var product: LFProduct? {
        didSet{
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
        setupUI()
    }

    
    //界面设置
    private func setupUI(){
        collectionView = UICollectionView(frame: CGRectMake(0, 0, SCREENW, 375), collectionViewLayout: LFDetailLayout())
        collectionView.registerClass(LFDetailCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "detailCollectionViewID")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        addSubview(collectionView)

        //pageControll
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        addSubview(pageControl)
        //标题
        titleLabel.lineBreakMode = .ByWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.blackColor()
        addSubview(titleLabel)
        //价格
        priceLabel.numberOfLines = 0
        priceLabel.textColor = LFGlobalRedColor()
        priceLabel.font = UIFont.systemFontOfSize(16)
        addSubview(priceLabel)
        //详细描述
        describeLabel.lineBreakMode = .ByWordWrapping
        describeLabel.numberOfLines = 0
        describeLabel.textColor = LFColor(0, g: 0, b: 0, a: 0.6)
        describeLabel.font = UIFont.systemFontOfSize(15)
        addSubview(describeLabel)
        
        pageControl.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.centerY.equalTo(collectionView.snp_bottom).offset(-30)
        }
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(collectionView.snp_bottom).offset(5)
            make.left.equalTo(self).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
            make.height.equalTo(30)
        }
        
        priceLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(titleLabel.snp_left)
            make.right.equalTo(titleLabel.snp_right)
            make.top.equalTo(titleLabel.snp_bottom).offset(5)
            make.height.equalTo(25)
        }

        describeLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(priceLabel.snp_left)
            make.right.equalTo(priceLabel.snp_right)
            make.top.equalTo(priceLabel.snp_bottom).offset(5)
            make.bottom.equalTo(self.snp_bottom).offset(-5)
        }

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LFProductDetailTopView: UICollectionViewDelegate, UICollectionViewDataSource{
    //MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count ?? 0
    }
    //MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("detailCollectionViewID", forIndexPath: indexPath) as! LFDetailCollectionViewCell
        let url = imageURLs[indexPath.item]
        cell.bgImageView.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) -> () in
                cell.placeholderButton.hidden = true
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.item
        SVProgressHUD.showWithStatus(String(index))
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let page = offsetX / scrollView.frame.size.width
        pageControl.currentPage = Int(page + 0.5)
    }
}

private class LFDetailLayout: UICollectionViewFlowLayout{
    //准备布局
    private override func prepareLayout() {
        //设置layout 布局
        itemSize = CGSizeMake(SCREENW,375)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .Horizontal
        //设置contentView 属性
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.bounces = false
        collectionView?.pagingEnabled = true
    }
}
