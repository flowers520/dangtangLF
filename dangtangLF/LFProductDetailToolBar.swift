//
//  LFProductDetailToolBar.swift
//  dangtangLF
//
//  Created by jim on 17/2/1.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

protocol LFProductDetailToolBarDelegate: NSObjectProtocol{
    func toolBarDidClickedTMALLButton()
}

class LFProductDetailToolBar: UIView {

    weak var delegate: LFProductDetailToolBarDelegate?
    var toolView: UIView!
    var likeButton: UIButton!
    var TMButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置界面
        setupUI()
    }
    //设置界面
    func setupUI(){
        self.frame = CGRectMake(0, 0, 600, 45)
        
        toolView.frame = CGRectMake(0, 0, 600, 1)
        addSubview(toolView)
        
        likeButton.frame = CGRectMake(15, 5, 100, 35)
        likeButton.layer.borderColor = LFGlobalRedColor().CGColor
        likeButton.layer.borderWidth = KlineWidth
        likeButton.setTitle("喜欢", forState: .Normal)
        likeButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        likeButton.setImage(UIImage(named: "content-details_like_16x16_"), forState: .Normal)
        likeButton.setImage(UIImage(named: "content-details_like_selected_16x16_"), forState: .Selected)
        addSubview(likeButton)
        
        TMButton.frame = CGRectMake(133, 5, 452, 35)
        TMButton.setTitle("去天猫购买", forState: .Normal)
        TMButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        TMButton.backgroundColor = UIColor.redColor()
        addSubview(TMButton)
        
    }
    
    
    func likeButtonClick(sender: UIButton){
        //判断是否登录
        if NSUserDefaults.standardUserDefaults().boolForKey(isLogin){
            sender.selected = !sender.selected
        }else{
            let loginVC = LFLoginViewController()
            loginVC
        }
    }
    func goTMALLButtonClick(){
        delegate?.toolBarDidClickedTMALLButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
