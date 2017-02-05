//
//  LFCollectionViewCell.swift
//  dangtangLF
//
//  Created by jim on 17/2/1.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit
import Kingfisher

protocol LFCollectionViewCellDelegate: NSObjectProtocol{
    func collectionViewCellDidClickedLikeButton(button: UIButton)
}

class LFCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: LFCollectionViewCellDelegate?
    /*
        占位图片
        背景图片
        标题
        价格
        喜欢按钮
    */
    var placeholderBtn: UIButton!
    var productImageView: UIImageView!
    var titleLabel: UILabel!
    var priceLabel: UILabel!
    var likeButton: UIButton!
    
    var result: LFSearchResult?{
        didSet{
            let url = result?.cover_image_url!
            productImageView.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) {(image,error,cacheType,imageURL) in
                self.placeholderBtn.hidden = true
            }
            likeButton.setTitle(" " + String(result!.favorite_count!), forState: .Normal)
            titleLabel.text = result!.name
            priceLabel.text = "￥" + String(result!.price!)
        }
    }
    var product: LFProduct?{
        didSet{
            let url = product?.cover_image_url!
            productImageView.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) -> () in
                self.placeholderBtn.hidden = true
            }
            likeButton.setTitle(" " + String(product!.favorites_count!), forState: .Normal)
            titleLabel.text = product!.name
            priceLabel.text = "￥" + String(product!.price!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //界面设置
        setupUI()
    }
    //界面设置
    private func setupUI(){
        
        self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = kCornerRadius
        self.layer.masksToBounds = true
        
        productImageView = UIImageView(frame: CGRectMake(0, 0, SCREENW/2-10, 164))
        addSubview(productImageView)
        
        placeholderBtn = UIButton(frame: CGRect(x: (SCREENW/2-10-31)/2, y: 69, width: 31, height: 26))
        placeholderBtn.setTitleColor(UIColor.clearColor(), forState: .Normal)
        placeholderBtn.setImage(UIImage(named: "PlaceHolderImage_small_31x26_"), forState: .Normal)
        addSubview(placeholderBtn)
        
        titleLabel = UILabel(frame: CGRectMake(5, 164, SCREENW/2-10-10, 60))
        titleLabel.text = "Label"
        titleLabel.lineBreakMode = .ByWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.font = UIFont.systemFontOfSize(15)
        addSubview(titleLabel)
        
        priceLabel = UILabel(frame: CGRectMake(5, 215, (SCREENW/2-10-10)/2, 25))
        priceLabel.text = "Label"
        priceLabel.textColor = UIColor.redColor()
        priceLabel.font = UIFont.systemFontOfSize(15)
        addSubview(priceLabel)
        
        likeButton = UIButton(frame: CGRectMake(SCREENW/2-10+5-50-5, 215, 50, 25))
        likeButton.setTitle("0", forState: .Normal)
        likeButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        likeButton.setImage(UIImage(named: "Search_GiftBtn_Default_12x10_"), forState: .Normal)
        likeButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        likeButton.addTarget(self, action: Selector("likeButtonClick:"), forControlEvents: .TouchUpInside)
        addSubview(likeButton)
        
    }
    
    
    func likeButtonClick(sender: UIButton){
        delegate?.collectionViewCellDidClickedLikeButton(sender)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
