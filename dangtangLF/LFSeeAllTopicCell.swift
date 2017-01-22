//
//  LFSeeAllTopicCell.swift
//  dangtangLF
//
//  Created by jim on 17/1/17.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFSeeAllTopicCell: UITableViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var placeholderButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
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
    
}
