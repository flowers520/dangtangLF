//
//  LFSortCell.swift
//  dangtangLF
//
//  Created by jim on 17/1/31.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFSortCell: UITableViewCell {

    var viewCell: UIView!
    var titleLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    //界面设置
    func setupUI(){
        self.frame = CGRectMake(0, 0, 320, 43)
        
        viewCell.frame = CGRectMake(0, 42, 320, 1)
        addSubview(viewCell)
        
        titleLabel.frame = CGRectMake(10, 0, 310, 43)
        titleLabel.text = "Label"
        titleLabel.textColor = UIColor.whiteColor()
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
