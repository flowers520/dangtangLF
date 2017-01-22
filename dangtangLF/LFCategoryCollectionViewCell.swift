//
//  LFCategoryCollectionViewCell.swift
//  dangtangLF
//
//  Created by jim on 17/1/17.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit
import Kingfisher

class LFCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var placeholderButton: UIButton!
    @IBOutlet weak var collectionImageView: UIImageView!
    
    var collection: LFCollection?{
        didSet{
            let url = collection?.banner_image_url
            print(url)
//            collectionImageView.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) -> () in
//                self.placeholderButton.hidden = true
//            }
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
