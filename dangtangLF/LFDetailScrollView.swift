//
//  LFDetailScrollView.swift
//  dangtangLF
//
//  Created by jim on 17/2/1.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFDetailScrollView: UIScrollView {

    //上部滚动视图（产品简介）
    var topScrollView = LFProductDetailTopView()
    //下部滚动视图（图文|评论）
    var bottomScrollView = LFProductDetailBottomView()
    
    var product: LFProduct?{
        didSet{
            topScrollView.product = product
            bottomScrollView.product = product
        }
    }

    var result: LFSearchResult?{
        didSet{
            topScrollView.result = result
            bottomScrollView.result = result
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    //界面设置
    private func setupUI(){
        //上部滚动视图（产品简介)
        topScrollView.backgroundColor = UIColor.whiteColor()
        addSubview(topScrollView)
        //下部滚动视图（图文|评论）
        bottomScrollView.backgroundColor = UIColor.whiteColor()
        addSubview(bottomScrollView)
        
        topScrollView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.size.equalTo(CGSizeMake(SCREENW, 520))
        }

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
