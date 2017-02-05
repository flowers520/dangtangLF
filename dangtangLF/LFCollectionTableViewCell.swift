//
//  LFCollectionTableViewCell.swift
//  dangtangLF
//
//  Created by jim on 17/1/30.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFCollectionTableViewCell: UITableViewCell {

    var placeholderButton: UIButton!
    var bgImageView: UIImageView!
    var titleLabel: UILabel!
    var likeButton: UIButton!
    
    var collectionPost: LFCollectionPost? {
        didSet {
            let url = collectionPost!.cover_image_url
            bgImageView.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
                self.placeholderButton.hidden = true
            }
            titleLabel.text = collectionPost!.title
            likeButton.setTitle("\(collectionPost!.likes_count!)", forState: .Normal)
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgImageView.layer.cornerRadius = kCornerRadius
        bgImageView.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置UI
    func setupUI(){
        self.bgImageView = UIImageView(frame: CGRectMake(8, 8, SCREENW-8-8, 134))
        bgImageView.layer.cornerRadius = kCornerRadius
        bgImageView.layer.masksToBounds = true
        self.addSubview(bgImageView)
        
        self.placeholderButton = UIButton(frame: CGRectMake((SCREENW-31)/2,62,31,26))
        self.placeholderButton.setImage(UIImage(named: "PlaceHolderImage_small_31x26_"), forState: .Normal)
        self.addSubview(placeholderButton)
        
        self.titleLabel = UILabel(frame: CGRectMake(13,115,SCREENW-13-13,21))
        self.titleLabel.font = UIFont.systemFontOfSize(14)
        self.titleLabel.textColor = UIColor.whiteColor()
        self.addSubview(titleLabel)
        
        self.likeButton = UIButton(frame: CGRectMake((SCREENW-13-50),13,50,25))
        self.likeButton.backgroundColor = UIColor.clearColor()
        self.likeButton.setImage(UIImage(named: "Feed_FavoriteIcon_17x17_"), forState: .Normal)
        self.likeButton.setTitle("0", forState: .Normal)
        self.likeButton.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        self.likeButton.titleLabel?.textColor = UIColor.whiteColor()
        self.addSubview(self.likeButton)
        
    }

}
