//
//  LFSettingCell.swift
//  dangtangLF
//
//  Created by jim on 17/2/3.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFSettingCell: UITableViewCell {

    var disclosureIndicator = UIImageView()
    var rightLabel = UILabel()
    var switchView = UISwitch()
    var leftLabel = UILabel()
    var lineView = UIView()
    var iconImageView = UIImageView()
    
    var setting: LFSetting? {
        didSet{
            iconImageView.image = UIImage(named: setting!.iconImage!)
            leftLabel.text = setting?.leftTitle
            rightLabel.text = setting?.rightTitle
            disclosureIndicator.hidden = setting!.isHiddenRightTip!
            switchView.hidden = setting!.isHiddenSwitch!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    //界面设置
    private func setupUI(){
        
        iconImageView.frame = CGRectMake(10, 11, 21, 21)
        iconImageView.image = UIImage(named: "more_icon_score_21x21_")
        addSubview(iconImageView)
        
        lineView.frame = CGRectMake(41, 43, SCREENW-41-10, 1)
        lineView.backgroundColor = UIColor.blackColor()
        addSubview(lineView)
        
        leftLabel.frame = CGRectMake(41, 0, (SCREENW-41-10-20-8)/2, 43)
        leftLabel.text = "Label"
        leftLabel.textColor = UIColor.blackColor()
        leftLabel.font = UIFont.systemFontOfSize(17)
        addSubview(leftLabel)
        
        switchView.frame = CGRectMake(SCREENW-51-10-20-8, 6, 51, 31)
        switchView.setOn(true, animated: true)
        addSubview(switchView)
        
        rightLabel.frame = CGRectMake((SCREENW-41-10-20-8)/2+41, 0, (SCREENW-41-10-20-8)/2, 44)
        rightLabel.text = "Label"
        rightLabel.textAlignment = NSTextAlignment.Right
        rightLabel.textColor = UIColor.blackColor()
        rightLabel.font = UIFont.systemFontOfSize(17)
        addSubview(rightLabel)
        
        disclosureIndicator.frame = CGRectMake(SCREENW-10-8-10, 16, 8, 12)
        disclosureIndicator.image = UIImage(named: "CellDisclosureIndicator_8x12_")
        addSubview(disclosureIndicator)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
