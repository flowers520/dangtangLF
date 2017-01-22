//
//  LFVerticalButton.swift
//  dangtangLF
//
//  Created by jim on 17/1/16.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit
import Kingfisher

class LFVerticalButton: UIButton {

    var group: LFGroup? {
        didSet{
            let url = group?.icon_url
            imageView?.kf_setImageWithURL(NSURL(string: url!)!)
            titleLabel?.text = group?.name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .Center
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //调整图片
        imageView?.frame.origin.x = 10
        imageView?.frame.origin.y = 0
        imageView?.frame.size.width = self.frame.width-20
        imageView?.frame.size.height = (imageView?.frame.size.width)!
        
        //调整文字
        titleLabel?.frame.origin.x = 0
        titleLabel?.frame.origin.y = (imageView?.frame.size.height)!
        titleLabel?.frame.size.width = self.frame.width
        titleLabel?.frame.size.height = (self.frame.size.height - (self.titleLabel?.frame.origin.y)!)
    }
    
}
