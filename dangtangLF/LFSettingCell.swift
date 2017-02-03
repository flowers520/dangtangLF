//
//  LFSettingCell.swift
//  dangtangLF
//
//  Created by jim on 17/2/3.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFSettingCell: UITableViewCell {

    var disclosureIndicator: UIImageView!
    var rightLabel: UILabel!
    var switchView: UISwitch!
    var leftLabel: UILabel!
    var lineView: UIView!
    var iconImageView: UIImageView!
    
    var setting: LFSetting? {
        didSet{
            iconImageView.image = UIImage(named: setting!.iconImage!)
            leftLabel.text = setting?.leftTitle
            rightLabel.text = setting?.rightTitle
            disclosureIndicator.hidden = true
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
    func setupUI(){
        self.frame = CGRectMake(0, 0, 320, 43)
        
        iconImageView.frame = CGRectMake(10, 11, 21, 21)
        iconImageView.image = UIImage(named: "more_icon_score_21x21_")
        addSubview(iconImageView)
        
        lineView.frame = CGRectMake(41, 43, 279, 1)
        lineView.backgroundColor = UIColor.blackColor()
        addSubview(lineView)
        
        leftLabel.frame = CGRectMake(41, 0, 42, 43)
        leftLabel.text = "Label"
        leftLabel.textColor = UIColor.blackColor()
        leftLabel.font = UIFont.systemFontOfSize(17)
        addSubview(leftLabel)
        
        switchView.frame = CGRectMake(243, 6, 51, 31)
        switchView.setOn(true, animated: true)
        addSubview(switchView)
        
        rightLabel.frame = CGRectMake(250, 0, 42, 44)
        rightLabel.text = "Label"
        rightLabel.textColor = UIColor.blackColor()
        rightLabel.font = UIFont.systemFontOfSize(17)
        addSubview(rightLabel)
        
        disclosureIndicator.frame = CGRectMake(302, 15, 8, 12)
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
