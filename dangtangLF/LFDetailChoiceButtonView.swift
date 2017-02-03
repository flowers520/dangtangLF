//
//  LFDetailChoiceButtonView.swift
//  dangtangLF
//
//  Created by jim on 17/2/1.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

protocol LFDetailChoiceButtonViewDelegate: NSObjectProtocol{
    //图文介绍按钮点击
    func choiceIntroduceButtonClick()
    //评论按钮点击
    func choichCommentButtonClick()
}

class LFDetailChoiceButtonView: UIView {

    
    var lineView =  UIView()
    var hLineView = UIView()
    var leadingConstraint = NSLayoutConstraint()
    //图文介绍
    var introduceButton = UIButton()
    //评论
    var commentButton = UIButton()
    
    weak var delegate: LFDetailChoiceButtonViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    //图文介绍
    func introduceButton(sender: UIButton){
        UIView.animateWithDuration(kAnimationDuration) { () -> Void in
            self.lineView.frame.origin.x = 0
        }
        delegate?.choiceIntroduceButtonClick()
    }
    //评论
    func commentButtonClick(sender: UIButton){
        UIView.animateWithDuration(kAnimationDuration) { () -> Void in
            self.lineView.frame.origin.x = SCREENW * 0.5
        }
        delegate?.choichCommentButtonClick()
    }
    //界面设置
    private func setupUI(){
        self.frame = CGRectMake(0, 0, 600, 44)
        //view
        lineView.frame = CGRectMake(0, 42, 300, 2)
        lineView.backgroundColor = UIColor.redColor()
        addSubview(lineView)
        hLineView.frame = CGRectMake(300, 0, 1, 42)
        hLineView.backgroundColor = UIColor.grayColor()
        addSubview(hLineView)
        //button
        introduceButton.frame = CGRectMake(0, 0, 300, 44)
        introduceButton.setTitle("图文介绍", forState: .Normal)
        introduceButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        introduceButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        introduceButton.addTarget(self, action: Selector("graphicButton"), forControlEvents: .TouchUpInside)
        addSubview(introduceButton)
        commentButton.frame = CGRectMake(300, 0, 300, 44)
        commentButton.setTitle("评论", forState: .Normal)
        commentButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        commentButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        commentButton.addTarget(self, action: Selector("commentButtonClick"), forControlEvents: .TouchUpInside)
        addSubview(commentButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
