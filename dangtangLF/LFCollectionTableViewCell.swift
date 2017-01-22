//
//  LFCollectionTableViewCell.swift
//  dangtangLF
//
//  Created by jim on 17/1/17.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit
import Kingfisher

class LFCollectionTableViewCell: UITableViewCell {
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var placeholderButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var collectionPost: LFCollectionPost?{
        didSet{
            let url = collectionPost?.cover_image_url
            bgImageView.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) -> () in
                self.placeholderButton.hidden = true
            }
            titleLabel.text = collectionPost?.title
            likeButton.setTitle("\(collectionPost?.likes_count)", forState: .Normal)
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
