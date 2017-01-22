//
//  LFCategoryBottomView.swift
//  dangtangLF
//
//  Created by jim on 17/1/16.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit
import Kingfisher

protocol LFCategoryBottomViewDelegate: NSObjectProtocol{
    func bottomViewButtonDidClicked(button: UIButton)
}

class LFCategoryBottomView: UIView {

    weak var delegate:LFCategoryBottomViewDelegate?
    
    var outGroups = [AnyObject]()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        //分类界面 风格，品格
        LFNetworkTool.shareNetworkTool.loadCategoryGroup { [weak self](outGroups) -> () in
            self?.outGroups = outGroups
            self!.setupUI()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        let topGroups = outGroups[0] as! NSArray
        let bottomGroups = outGroups[1] as! NSArray
        
        //风格
        let topView = UIView()
        topView.frame.size.width = SCREENW
        topView.backgroundColor = UIColor.whiteColor()
        addSubview(topView)
        let styleLabel = setupLabel("风格")
        topView.addSubview(styleLabel)
        
        for index in 0..<topGroups.count{
            let group = topGroups[index] as! LFGroup
            let button = setupButton(index,group: group)
            topView.addSubview(button)
            if index == topGroups.count - 1{
                topView.frame.size.height = CGRectGetMaxY(button.frame) + kMargin
            }
        }
        
        //品类
        let bottomView = UIView()
        bottomView.frame.size.width = SCREENW
        bottomView.frame.origin.y = CGRectGetMaxY(topView.frame) + kMargin
        bottomView.backgroundColor = UIColor.whiteColor()
        addSubview(bottomView)
        let categoryLabel = setupLabel("品类")
        bottomView.addSubview(categoryLabel)
        
        for index in 0..<bottomGroups.count {
            let group = bottomGroups[index] as! LFGroup
            let button = setupButton(index, group: group)
            bottomView.addSubview(button)
            if index == bottomGroups.count - 1{
                bottomView.frame.size.height = CGRectGetMaxY(button.frame) + kMargin
            }
        }
        
    }
    
    private func setupButton(index: Int,group: LFGroup)->LFVerticalButton{
        let buttonW: CGFloat = SCREENW / 4
        let buttonH: CGFloat = buttonW
        let styleLabelH: CGFloat = 40
        
        let button = LFVerticalButton()
        button.frame.size.width = buttonW
        button.frame.size.height = buttonH
        button.frame.origin.x = buttonW * CGFloat(index % 4)
        button.frame.origin.y = buttonH * CGFloat(index / 4) + styleLabelH
        
        if index > 3 {
            button.frame.origin.y = buttonH * CGFloat(index / 4) + styleLabelH + kMargin
        }
        button.tag = group.id!
        button.addTarget(self, action: Selector("groupButtonClick:"), forControlEvents: .TouchUpInside)
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        button.setTitleColor(LFColor(0, g: 0, b: 0, a: 0.6), forState: .Normal)
        button.kf_setImageWithURL(NSURL(string: group.icon_url!)!, forState: .Normal)
        button.setTitle(group.name, forState: .Normal)
        return button
    }
    
    func groupButtonClick(button: UIButton){
        delegate?.bottomViewButtonDidClicked(button)
    }
    
    private func setupLabel(title: String)->UILabel{
        let styleLabel = UILabel(frame: CGRectMake(10,0,SCREENW - 10,40))
        styleLabel.text = title
        styleLabel.textColor = LFColor(0, g: 0, b: 0, a: 0.6)
        styleLabel.font = UIFont.systemFontOfSize(16)
        return styleLabel
    }

}
