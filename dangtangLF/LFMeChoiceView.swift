

import UIKit

class LFMeChoiceView: UIView {
    //左边按钮
    var leftButton = UIButton()
    //右边按钮
    var rightButton = UIButton()
    //底部红条
    var indicatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    func leftButtonClick(button: UIButton) {
        button.selected = !button.selected
        UIView.animateWithDuration(kAnimationDuration) {
            self.indicatorView.x = 0
        }
    }
    
    func rightButtonClick(button: UIButton) {
        button.selected = !button.selected
        UIView.animateWithDuration(kAnimationDuration) {
            self.indicatorView.x = SCREENW * 0.5
        }
    }

    
    //界面设置
    private func setupUI(){

        leftButton.setTitle("喜欢的商品", forState: .Normal)
        leftButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        leftButton.setTitleColor(LFColor(0, g: 0, b: 0, a: 0.7), forState: .Normal)
        leftButton.backgroundColor = UIColor.whiteColor()
        leftButton.addTarget(self, action: Selector("leftButtonClick:"), forControlEvents: .TouchUpInside)
        leftButton.layer.borderColor = LFColor(230, g: 230, b: 230, a: 1.0).CGColor
        leftButton.layer.borderWidth = KlineWidth
        leftButton.selected = true
        addSubview(leftButton)

        rightButton.setTitle("喜欢的专题", forState: .Normal)
        rightButton.setTitleColor(LFColor(0, g: 0, b: 0, a: 0.7), forState: .Normal)
        rightButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        rightButton.backgroundColor = UIColor.whiteColor()
        rightButton.addTarget(self, action: Selector("rightButtonClick:"), forControlEvents: .TouchUpInside)
        rightButton.layer.borderColor = LFColor(230, g: 230, b: 230, a: 1.0).CGColor
        rightButton.layer.borderWidth = KlineWidth
        addSubview(rightButton)
        
        indicatorView.backgroundColor = LFGlobalRedColor()
        addSubview(indicatorView)
        
        leftButton.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(rightButton)
        }

        rightButton.snp_makeConstraints { (make) in
            make.left.equalTo(leftButton.snp_right)
            make.top.right.bottom.equalTo(self)
        }
        
        indicatorView.snp_makeConstraints { (make) in
            make.height.equalTo(kIndicatorViewH)
            make.bottom.left.equalTo(self)
            make.right.equalTo(leftButton)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
