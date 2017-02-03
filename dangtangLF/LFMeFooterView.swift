//
//  LFMeFooterView.swift
//  dangtangLF
//
//  Created by jim on 17/2/3.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit
import Kingfisher

class LFMeFooterView: UIView {
    
    var meBlankButton: UIButton!
    var messageLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    //界面设置
    private func setupUI(){
        meBlankButton.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(50, 50))
            make.center.equalTo(self.center)
        }
        meBlankButton.setTitleColor(LFColor(200, g: 200, b: 200, a: 1.0), forState: .Normal)
        meBlankButton.width = 100
        meBlankButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        meBlankButton.setImage(UIImage(named: "Me_blank_50x50_"), forState: .Normal)
        meBlankButton.addTarget(self, action: Selector("footerViewButtonClick"), forControlEvents: .TouchUpInside)
        meBlankButton.imageView?.sizeToFit()
        addSubview(meBlankButton)
        
        messageLabel.snp_makeConstraints { (make) in
            make.top.equalTo(meBlankButton.snp_bottom).offset(kMargin)
            make.left.right.equalTo(self)
        }
        messageLabel.text = "登录以享受功能"
        messageLabel.textAlignment = .Center
        messageLabel.font = UIFont.systemFontOfSize(15)
        messageLabel.textColor = LFColor(200, g: 200, b: 200, a: 1.0)
        addSubview(messageLabel)

    }
    
    func footerViewButtonClick() {
        let nav = LFNavigationController(rootViewController: LFLoginViewController())
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(nav, animated: true, completion: nil)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
