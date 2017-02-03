//
//  LFMineHeaderView.swift
//  dangtangLF
//
//  Created by jim on 17/2/3.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit
import SnapKit

class LFMineHeaderView: UIView {

    var bgImageView: UIImageView!
    var messageButton: UIButton!
    var settingButton: UIButton!
    var iconButton: UIButton!
    var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //初始化界面
        setupUI()
    }

    private func setupUI(){
        // 布局
        bgImageView.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(self)
            make.top.equalTo(-20)
        }
        bgImageView.contentMode = .ScaleAspectFill
        bgImageView.image = UIImage(named: "Me_ProfileBackground")
        addSubview(bgImageView)
        
        settingButton.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(44, 44))
            make.right.equalTo(self)
            make.top.equalTo(0)
        }
        settingButton.setImage(UIImage(named: "Me_settings_20x20_"), forState: .Normal)
        addSubview(settingButton)
        
        messageButton.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(44, 44))
            make.left.equalTo(self)
            make.top.equalTo(settingButton.snp_top)
        }
        messageButton.setImage(UIImage(named: "Me_message_20x20_"), forState: .Normal)
        addSubview(messageButton)
        
        iconButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.centerX)
            make.size.equalTo(CGSizeMake(75, 75))
            make.bottom.equalTo(nameLabel.snp_top).offset(-kMargin)
        }
        iconButton.setBackgroundImage(UIImage(named: "Me_AvatarPlaceholder_75x75_"), forState: .Normal)
        iconButton.layer.cornerRadius = iconButton.width * 0.5
        iconButton.layer.masksToBounds = true
        addSubview(iconButton)
        
        nameLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottom).offset(-3 * kMargin)
            make.left.right.equalTo(self)
            make.height.equalTo(2 * kMargin)
        }
        nameLabel.text = "hrscy"
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.font = UIFont.systemFontOfSize(15.0)
        nameLabel.textAlignment = .Center
        addSubview(nameLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
