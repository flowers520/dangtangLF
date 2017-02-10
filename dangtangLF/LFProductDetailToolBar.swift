

import UIKit

protocol LFProductDetailToolBarDelegate: NSObjectProtocol{
    func toolBarDidClickedTMALLButton()
}

class LFProductDetailToolBar: UIView {

    weak var delegate: LFProductDetailToolBarDelegate?
    var toolView = UIView()
    var likeButton = UIButton()
    var TMButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置界面
        setupUI()
    }
    //设置界面
    private func setupUI(){
        self.frame = CGRectMake(0, 0, 600, 45)
        
        toolView.frame = CGRectMake(0, 0, 600, 1)
        addSubview(toolView)
        
        likeButton.frame = CGRectMake(15, 5, 100, 35)
        likeButton.layer.borderColor = LFGlobalRedColor().CGColor
        likeButton.layer.borderWidth = KlineWidth
        likeButton.layer.cornerRadius = kCornerRadius
        likeButton.layer.masksToBounds = true
        likeButton.setTitle("喜欢", forState: .Normal)
        likeButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        likeButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        likeButton.setImage(UIImage(named: "content-details_like_16x16_"), forState: .Normal)
        likeButton.setImage(UIImage(named: "content-details_like_selected_16x16_"), forState: .Selected)
        likeButton.addTarget(self, action: Selector("likeButtonClick:"), forControlEvents: .TouchUpInside)
        addSubview(likeButton)
        
        TMButton.frame = CGRectMake(133, 5, SCREENW-133-15, 35)
        TMButton.setTitle("去天猫购买", forState: .Normal)
        TMButton.layer.cornerRadius = kCornerRadius
        TMButton.layer.masksToBounds = true
        TMButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        TMButton.backgroundColor = UIColor.redColor()
        TMButton.addTarget(self, action: Selector("goTMALLButtonClick"), forControlEvents: .TouchUpInside)
        addSubview(TMButton)
        
    }
    
    
    func likeButtonClick(sender: UIButton){
        //判断是否登录
        if NSUserDefaults.standardUserDefaults().boolForKey(isLogin){
            sender.selected = !sender.selected
        }else{
            let loginVC = LFLoginViewController()
            loginVC.title = "登录"
            let nav = LFNavigationController(rootViewController: loginVC)
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(nav, animated: true, completion: nil)
        }
    }
    func goTMALLButtonClick(){
        delegate?.toolBarDidClickedTMALLButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
