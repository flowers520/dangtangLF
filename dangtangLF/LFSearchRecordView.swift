//
//  LFSearchRecordView.swift
//  dangtangLF
//
//  Created by jim on 17/1/31.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFSearchRecordView: UIView {

    //关键字
    var words = [String]()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        //搜索界面数据获取热搜关键字
        weak var weakSelf = self
        LFNetworkTool.shareNetworkTool.loadHotWords { (hot_words) -> () in
            weakSelf!.words = hot_words
            weakSelf!.setupUI()
        }
    }
    
    //界面设置
    func setupUI(){
        //大家都在搜
        let topView = UIView()
        addSubview(topView)
        
        let hotLabel = setupLabel("大家都在搜")
        hotLabel.frame = CGRectMake(10, 20, 200, 20)
        topView.addSubview(hotLabel)
        
        //历史记录
        let bottomView = UIView()
        addSubview(bottomView)
    }
    
    func setupLabel(title: String)->UILabel{
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFontOfSize(13)
        label.textColor = LFColor(0, g: 0, b: 0, a: 0.6)
        return label
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
