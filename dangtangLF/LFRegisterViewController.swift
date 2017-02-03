
import UIKit
import SVProgressHUD

class LFRegisterViewController: LFBaseViewController {
    
    var mobileView = UIView()
    var mobileLabel = UILabel()
    var hintLabel = UILabel()
    var mobileField = UITextField()
    var vertifyButton = UIButton()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mobileField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        mobileField.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //界面设置
        setupUI()
    }
    
    //界面设置
    func setupUI(){
        
        mobileView.frame = CGRectMake(0, 108, SCREENW, 42)
        self.view.addSubview(mobileView)
        
        mobileField.frame = CGRectMake(10, 0, SCREENW-10-10, 42)
        mobileField.placeholder = "请输入手机号"
        mobileField.textColor = UIColor.blackColor()
        mobileField.font = UIFont.systemFontOfSize(17)
        mobileField.textAlignment = .Left
        mobileField.keyboardType = .PhonePad
        self.mobileView.addSubview(mobileField)
        
        hintLabel.frame = CGRectMake(10, 78, 272, 20)
        hintLabel.text = "请用合格手机接收验证码"
        hintLabel.textColor = UIColor.grayColor()
        hintLabel.font = UIFont.systemFontOfSize(16)
        hintLabel.textAlignment = .Left
        self.view.addSubview(hintLabel)
        
        vertifyButton.frame = CGRectMake(15, 190, SCREENW-15-15, 40)
        vertifyButton.setTitle("发送验证码短信", forState: .Normal)
        vertifyButton.layer.cornerRadius = kCornerRadius
        vertifyButton.layer.masksToBounds = true
        vertifyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        vertifyButton.titleLabel?.font = UIFont.systemFontOfSize(17)
        vertifyButton.backgroundColor = UIColor.redColor()
        vertifyButton.addTarget(self, action: Selector("vertifyButtonClick"), forControlEvents: .TouchUpInside)
        self.view.addSubview(vertifyButton)
    }
    //获取验证短信
    func vertifyButtonClick(){
        //先判断手机号码是否合法
        SVProgressHUD.showInfoWithStatus("手机号是:\(mobileField.text)")
    }
}