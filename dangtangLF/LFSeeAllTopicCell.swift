//
//  LFSeeAllTopicCell.swift
//  dangtangLF
//
//  Created by jim on 17/1/17.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFSeeAllTopicCell: UITableViewCell {

    var bgImageView: UIImageView!
    var placeholderButton: UIButton!
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    
    var longView: UIView!
    var leftView: UIView!
    var rightView: UIView!
    var seeTopicImage: UIImageView!
    
    var collection: LFCollection?{
        didSet{
            let url = collection?.cover_image_url
            bgImageView.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) -> () in
                self.placeholderButton.hidden = true
            }
            titleLabel.text = collection?.title
            subtitleLabel.text = collection?.subtitle
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
    
    func setupUI(){
        bgImageView = UIImageView(frame: CGRectMake(8, 8, SCREENW-8-8, 144))
        bgImageView.layer.cornerRadius = kCornerRadius
        bgImageView.layer.masksToBounds = true
        addSubview(bgImageView)
        
        placeholderButton = UIButton(frame: CGRectMake(144,67,31,26))
        placeholderButton.setImage(UIImage(named: "PlaceHolderImage_small_31x26_"), forState: .Normal)
        addSubview(placeholderButton)
        
        titleLabel = UILabel(frame: CGRectMake(0,43,SCREENW,24))
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(20.0)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = "Label"
        addSubview(titleLabel)
        
        subtitleLabel = UILabel(frame: CGRectMake(0,93,SCREENW,21))
        subtitleLabel.text = "Label"
        subtitleLabel.textAlignment = .Center
        subtitleLabel.textColor = UIColor.whiteColor()
        subtitleLabel.font = UIFont.systemFontOfSize(17.0)
        subtitleLabel.adjustsFontSizeToFitWidth = true
        addSubview(subtitleLabel)
        
        longView = UIView(frame: CGRectMake(8,77,304,5))
        addSubview(longView)
        
        leftView = UIView(frame: CGRectMake(30,2,109,1))
        longView.addSubview(leftView)
        
        rightView = UIView(frame: CGRectMake(164,2,110,1))
        longView.addSubview(rightView)
        
        seeTopicImage = UIImageView(frame: CGRectMake(149, 0, 5, 5))
        longView.addSubview(seeTopicImage)
    }
    
}
