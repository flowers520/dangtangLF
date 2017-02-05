//
//  LFHomeCell.swift
//  dangtangLF
//
//  Created by jim on 17/1/14.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit
import Kingfisher

protocol LFHomeCellDelegate: NSObjectProtocol{
    func homeCellDidClickedFavoriteButton(button: UIButton)
}

class LFHomeCell: UITableViewCell {
    
    weak var delegate:LFHomeCellDelegate?
    
    var bgImageView: UIImageView!
    var favoriteBtn: UIButton!
    var placehoderBtn: UIButton!
    var titleLabel: UILabel!
    
    var homeItem: LFHomeItem? {
        didSet {
            let url = homeItem?.cover_image_url
            bgImageView.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil)
                { (image,error,cacheType,imageURL) in
                    self.placehoderBtn.hidden = true
            }
            titleLabel.text = homeItem?.title
            favoriteBtn.setTitle(String(homeItem!.likes_count!), forState: .Normal)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    //界面设置
    func setupUI(){
        bgImageView = UIImageView(frame: CGRectMake(8, 7, SCREENW-8-8, 144))
        bgImageView.layer.cornerRadius = kCornerRadius
        bgImageView.layer.masksToBounds = true
        //格式化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
        bgImageView.layer.rasterizationScale = UIScreen.mainScreen().scale
        bgImageView.layer.shouldRasterize = true
        addSubview(bgImageView)
        
        placehoderBtn = UIButton(frame: CGRectMake((SCREENW-31)/2,(SCREENH-26)/2,31,26))
        placehoderBtn.setImage(UIImage(named: "PlaceHolderImage_small_31x26_"), forState: .Normal)
        addSubview(placehoderBtn)
        
        titleLabel = UILabel(frame: CGRectMake(13,125,SCREENW-13-13,21))
//        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.systemFontOfSize(14)
        titleLabel.textColor = UIColor.whiteColor()
        addSubview(titleLabel)
        
        favoriteBtn = UIButton(frame: CGRectMake((SCREENW-10-50),18,50,25))
        favoriteBtn.layer.cornerRadius = favoriteBtn.bounds.height * 0.5
        favoriteBtn.layer.masksToBounds = true
        favoriteBtn.layer.rasterizationScale = UIScreen.mainScreen().scale
        favoriteBtn.layer.shouldRasterize = true
        favoriteBtn.backgroundColor = UIColor.clearColor()
        favoriteBtn.setTitle("0", forState: .Normal)
        favoriteBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        favoriteBtn.titleLabel?.textColor = UIColor.whiteColor()
        favoriteBtn.setImage(UIImage(named: "Feed_FavoriteIcon_17x17_"), forState: .Normal)
        favoriteBtn.addTarget(self, action: Selector("favoriteBtnClick:"), forControlEvents: .TouchUpInside)
        addSubview(favoriteBtn)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func favoriteBtnClick(sender: UIButton){
        delegate?.homeCellDidClickedFavoriteButton(sender)
    }

    
}
