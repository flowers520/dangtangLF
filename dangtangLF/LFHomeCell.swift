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
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var placehoderBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var homeItem: LFHomeItem? {
        didSet {
            let url = homeItem?.cover_image_url
            bgImageView.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil)
                { (image,error,cacheType,imageURL) in
                    self.placehoderBtn.hidden = true
            }
            titleLabel.text = homeItem?.title
            favoriteBtn.setTitle(" " + String(homeItem?.liked_count) + " ", forState: .Normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favoriteBtn.layer.cornerRadius = favoriteBtn.bounds.height * 0.5
        favoriteBtn.layer.masksToBounds = true
        favoriteBtn.layer.rasterizationScale = UIScreen.mainScreen().scale
        favoriteBtn.layer.shouldRasterize = true
        
        bgImageView.layer.cornerRadius = kCornerRadius
        bgImageView.layer.masksToBounds = true
        bgImageView.layer.rasterizationScale = UIScreen.mainScreen().scale
        bgImageView.layer.shouldRasterize = true
        
    }

    @IBAction func favoriteBtnClick(sender: UIButton){
        delegate?.homeCellDidClickedFavoriteButton(sender)
    }

    
}
