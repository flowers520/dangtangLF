//
//  LFTopHeaderButton.swift
//  dangtangLF
//
//  Created by jim on 17/1/22.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFTopHeaderButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        setImage(UIImage(named: "Category_PostCollectionSeeAll_5x8_"), forState: .Normal)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
    *  这个方法调整布局
    */

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.y = (titleLabel?.frame.size.width)!
    }
}
