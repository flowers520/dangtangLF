//
//  LFTopHeaderView.swift
//  dangtangLF
//
//  Created by jim on 17/1/17.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

protocol LFTopHeaderViewDelegate: NSObjectProtocol{
    func topViewDidClickedMoreButton(button: UIButton)
}

class LFTopHeaderView: UIView {

    weak var delegate: LFTopHeaderViewDelegate?
    
    @IBAction func viewAllButton(sender: UIButton) {
        delegate?.topViewDidClickedMoreButton(sender)
    }
    
}
