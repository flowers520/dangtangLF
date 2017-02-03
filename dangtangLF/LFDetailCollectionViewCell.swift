//
//  LFDetailCollectionViewCell.swift
//  dangtangLF
//
//  Created by jim on 17/2/1.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFDetailCollectionViewCell: UICollectionViewCell {
    
    var placeholderButton: UIButton!
    var bgImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //界面设置
        setupUI()
    }

    func setupUI(){
        self.frame = CGRectMake(0, 0, 206, 273)
        
        placeholderButton.frame = CGRectMake(87, 124, 31, 26)
        placeholderButton.titleLabel?.font = UIFont.systemFontOfSize(18)
        placeholderButton.setImage(UIImage(named: "PlaceHolderImage_small_31x26_"), forState: .Normal)
        addSubview(placeholderButton)
        
        bgImageView.frame = CGRectMake(0, 0, 206, 273)
        addSubview(bgImageView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
