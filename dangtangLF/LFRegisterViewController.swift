
import UIKit

class LFRegisterViewController: LFBaseViewController {
    
    var mobileView: UIView!
    var mobileLabel: UILabel!
    var hintLabel: UILabel!
    var mobileField: UITextField!
    var vertifyButton: UIButton!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mobileField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //界面设置
        setupUI()
    }
    
    //界面设置
    func setupUI(){
        self.view.frame = CGRectMake(0, 0, 600, 600)
        
        mobileView.frame = CGRectMake(0, 108, 600, 42)
        self.view.addSubview(mobileView)
        
        mobileField.frame = CGRectMake(10, 0, 580, 42)
        mobileField.placeholder = "请输入手机号"
        mobileField.textColor = UIColor.blackColor()
        mobileField.font = UIFont.systemFontOfSize(17)
        mobileField.textAlignment = .Left
        self.mobileView.addSubview(mobileField)
        
        hintLabel.frame = CGRectMake(10, 78, 272, 20)
        hintLabel.text = "请用合格手机接收验证码"
        hintLabel.textColor = UIColor.grayColor()
        hintLabel.font = UIFont.systemFontOfSize(16)
        hintLabel.textAlignment = .Left
        self.view.addSubview(hintLabel)
        
        vertifyButton.frame = CGRectMake(15, 190, 570, 40)
        vertifyButton.setTitle("获取验证码短信", forState: .Normal)
        vertifyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        vertifyButton.titleLabel?.font = UIFont.systemFontOfSize(17)
        vertifyButton.backgroundColor = UIColor.redColor()
        self.view.addSubview(vertifyButton)
    }
    
}