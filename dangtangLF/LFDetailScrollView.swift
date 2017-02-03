//
//  LFDetailScrollView.swift
//  dangtangLF
//
//  Created by jim on 17/2/1.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFDetailScrollView: UIScrollView {

    //顶部滚动视图
    var topScrollView = LFProductDetailTopView()
    //底部滚动视图
    var bottomScrollView = LFProductDetailBottomView()
    
    var product: LFProduct?{
        didSet{
            topScrollView.product = product
            bottomScrollView.product = product
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    //界面设置
    private func setupUI(){
        topScrollView.backgroundColor = UIColor.whiteColor()
        addSubview(topScrollView)
        
        bottomScrollView.backgroundColor = UIColor.whiteColor()
        addSubview(bottomScrollView)
        
        topScrollView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.size.equalTo(CGSizeMake(SCREENW, 520))
        }

        //滚动视图
        bottomScrollView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(topScrollView.snp_bottom).offset(kMargin)
            make.size.equalTo(CGSizeMake(SCREENW, SCREENH - 64 - 45))
        }

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
