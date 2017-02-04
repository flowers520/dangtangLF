//
//  LFActionSheet.swift
//  dangtangLF
//
//  Created by jim on 17/2/1.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit
import SnapKit

class LFActionSheet: UIView {

    //底部view
    var bgView = UIView()
    //上部view
    var topView = UIView()
    //分享到标签
    var shareLabel = UILabel()
    //6个按钮
    var shareButtonView = LFShareButtonView()
    //取消按钮
    var cancelButton = UIButton()
    
    class func show() {
        let actionSheet = LFActionSheet()
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.addSubview(actionSheet)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //界面设置
        setupUI()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.frame = UIScreen.mainScreen().bounds
        self.backgroundColor = LFColor(0, g: 0, b: 0, a: 0.6)
        
        bgView.frame = CGRectMake(0, SCREENH, SCREENW, 280)
        addSubview(bgView)
        
        cancelButton.setTitle("取消", forState: .Normal)
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(18)
        cancelButton.setTitleColor(LFColor(37, g: 142, b: 240, a: 1.0), forState: .Normal)
        cancelButton.backgroundColor = UIColor.whiteColor()
        cancelButton.addTarget(self, action: Selector("cancelButtonClick"), forControlEvents: .TouchUpInside)
        cancelButton.layer.cornerRadius = kCornerRadius
        cancelButton.layer.masksToBounds = true
        topView.addSubview(cancelButton)

        topView.backgroundColor = UIColor.whiteColor()
        topView.layer.cornerRadius = kCornerRadius
        topView.layer.masksToBounds = true
        bgView.addSubview(topView)

        shareLabel.text = "分享到"
        shareLabel.textColor = LFColor(0, g: 0, b: 0, a: 0.7)
        shareLabel.textAlignment = .Center
        topView.addSubview(shareLabel)

        shareButtonView.frame = CGRectMake(0, 30, SCREENW-20, kTopViewH-30)
        topView.addSubview(shareButtonView)

        
        topView.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(cancelButton.snp_top).offset(-kMargin)
            make.left.equalTo(cancelButton.snp_left)
            make.right.equalTo(bgView).offset(-kMargin)
            make.height.equalTo(kTopViewH)
        }
        
        shareLabel.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(topView)
            make.height.equalTo(30)
        }

        cancelButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(bgView).offset(kMargin)
            make.right.bottom.equalTo(bgView).offset(-kMargin)
            make.height.equalTo(44)
        }
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        UIView.animateWithDuration(kAnimationDuration) { () -> Void in
            self.bgView.frame.origin.y = SCREENH - self.bgView.frame.size.height
        }
    }
    
    //取消按钮
    func cancelButtonClick(){
        UIView.animateWithDuration(kAnimationDuration, animations: {
                self.bgView.frame.origin.y = SCREENH
            }) {(_) in
               self.removeFromSuperview()
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        UIView.animateWithDuration(kAnimationDuration, animations: { () -> Void in
            self.bgView.frame.origin.y = SCREENH
            }) { (_) -> Void in
                self.removeFromSuperview()
        }
    }

}
