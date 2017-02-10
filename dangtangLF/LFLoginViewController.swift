

import UIKit
import SVProgressHUD

class LFLoginViewController: LFBaseViewController {

    //view
    var loginview: UIView!
    var loginLineView: UIView!
    var socialView: UIView!
    var socialLeftView: UIView!
    var socialRightView: UIView!
    //label
    var mobileLabel: UILabel!
    var passwordLabel: UILabel!
    var socialLabel: UILabel!
    //button
    //登录按钮
    var loginButton: UIButton!
    //忘记密码按钮
    var forgetPwdBtn: UIButton!
    var weiboButton: UIButton!
    var weChatButton: UIButton!
    var qqButton: UIButton!
    //textField
    //手机号
    var mobileField: UITextField!
    //密码
    var passwordField: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //界面设置
        setupUI()
        //设置导航栏的左右按钮
        setupBarButtonItem()
    }

    //MARK: - 导航栏按钮设置
    func setupBarButtonItem(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: Selector("cancelButtonClick"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: Selector("registerButtonClick"))
    }
    //登录按钮
    func loginButtonClick(sender: UIButton){
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: isLogin)
        dismissViewControllerAnimated(true, completion: nil)
    }
    //忘记密码
    func forgetPwdButtonClick(sender: UIButton){
        SVProgressHUD.showInfoWithStatus("忘记密码！")
    }
    
    //取消按钮点击
    func cancelButtonClick(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    //注册按钮点击
    func registerButtonClick(){
        let registerVC = LFRegisterViewController()
        registerVC.title = "注册"
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    //MARK: - 其他社交账号登录
    func otherLoginButtonClick(sender: UIButton){
        if let buttonType = LFOtherLoginButtonType(rawValue: sender.tag){
            switch buttonType {
            case .weiboLogin:
                SVProgressHUD.showInfoWithStatus("微博登录....")
                break
            case .wechatLogin:
                SVProgressHUD.showInfoWithStatus("微信登录....")
                break
            case .QQLogin:
                SVProgressHUD.showInfoWithStatus("QQ登录....")
                break
            default:
                break
            }
        }
    }
    
    //MARK: - 界面设置
    private func setupUI(){
        
        loginview = UIView(frame: CGRectMake(0, 100, SCREENW, 86))
        view.addSubview(loginview)
        //登录项
        loginLineView = UIView(frame: CGRectMake(15, 42, (SCREENW-15-15), 1))
        loginLineView.backgroundColor = UIColor.grayColor()
        loginview.addSubview(loginLineView)
        
        mobileLabel = UILabel(frame: CGRectMake(15, 0, 60, 43))
        mobileLabel.text = "手机号:"
        mobileLabel.textColor = UIColor.grayColor()
        mobileLabel.textAlignment = .Right
        mobileLabel.font = UIFont.systemFontOfSize(17)
        loginview.addSubview(mobileLabel)
        
        passwordLabel = UILabel(frame: CGRectMake(15, 43, 60, 43))
        passwordLabel.text = "密   码:"
        passwordLabel.textColor = UIColor.grayColor()
        passwordLabel.font = UIFont.systemFontOfSize(17)
        passwordLabel.textAlignment = .Right
        loginview.addSubview(passwordLabel)
        
        mobileField = UITextField(frame: CGRectMake(15+60+10, 0, SCREENW-85, 42))
        mobileField.placeholder = "请输入手机号码"
        mobileField.textAlignment = .Left
        mobileField.contentHorizontalAlignment = .Center
        mobileField.font = UIFont.systemFontOfSize(14)
        loginview.addSubview(mobileField)
     
        passwordField = UITextField(frame: CGRectMake(15+60+10, 43, SCREENW-85, 43))
        passwordField.placeholder = "请输入密码"
        passwordField.textAlignment = .Left
        passwordField.contentHorizontalAlignment = .Center
        passwordField.font = UIFont.systemFontOfSize(14)
        loginview.addSubview(passwordField)
        
        //登录按钮
        loginButton = UIButton(frame: CGRectMake(15, 216, SCREENW-15-15, 36))
        loginButton.setTitle("登录", forState: .Normal)
        loginButton.layer.cornerRadius = kCornerRadius
        loginButton.layer.masksToBounds = true
        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginButton.backgroundColor = UIColor.redColor()
        loginButton.titleLabel?.textAlignment = .Center
        loginButton.titleLabel?.font = UIFont.systemFontOfSize(17)
        loginButton.addTarget(self, action: Selector("loginButtonClick:"), forControlEvents: .TouchUpInside)
        view.addSubview(loginButton)
        
        //忘记密码
        forgetPwdBtn = UIButton(frame: CGRectMake(SCREENW-60-15, 267, 60, 30))
        forgetPwdBtn.setTitle("忘记密码", forState: .Normal)
        forgetPwdBtn.setTitleColor(UIColor.grayColor(), forState: .Normal)
        forgetPwdBtn.titleLabel?.textAlignment = .Center
        forgetPwdBtn.backgroundColor = UIColor.clearColor()
        forgetPwdBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        forgetPwdBtn.addTarget(self, action: Selector("forgetPwdButtonClick:"), forControlEvents: .TouchUpInside)
        view.addSubview(forgetPwdBtn)
        
        //社交
        socialView = UIView(frame: CGRectMake(0, 312, SCREENW, 30))
        view.addSubview(socialView)
        
        socialLabel = UILabel(frame: CGRectMake((SCREENW-112)/2, 0, 112, 30))
        socialLabel.text = "使用社交账号登录"
        socialLabel.textAlignment = .Center
        socialLabel.textColor = UIColor.grayColor()
        socialLabel.font = UIFont.systemFontOfSize(14)
        socialView.addSubview(socialLabel)
        
        socialLeftView = UIView(frame: CGRectMake(15, 14, (SCREENW-122)/2-15, 1))
        socialLeftView.backgroundColor = UIColor.grayColor()
        socialView.addSubview(socialLeftView)
        
        socialRightView = UIView(frame: CGRectMake((SCREENW-122)/2+112+15, 14, (SCREENW-122)/2-15, 1))
        socialRightView.backgroundColor = UIColor.grayColor()
        socialView.addSubview(socialRightView)
        
        //微博
        weiboButton = UIButton(frame: CGRectMake((SCREENW-30*2-70*3)/2, 362, 70, 70))
        weiboButton.setImage(UIImage(named: "Share_WeiboIcon_70x70_"), forState: .Normal)
        weiboButton.tag = 101
        weiboButton.addTarget(self, action: Selector("otherLoginButtonClick:"), forControlEvents: .TouchUpInside)
        view.addSubview(weiboButton)
        //微信
        weChatButton = UIButton(frame: CGRectMake((SCREENW-30*2-70*3)/2+100, 362, 70, 70))
        weChatButton.tag = 102
        weChatButton.addTarget(self, action: Selector("otherLoginButtonClick:"), forControlEvents: .TouchUpInside)
        weChatButton.setImage(UIImage(named: "Share_WeChatSessionIcon_70x70_"), forState: .Normal)
        view.addSubview(weChatButton)
        //qq
        qqButton = UIButton(frame: CGRectMake((SCREENW-30*2-70*3)/2+200, 362, 70, 70))
        qqButton.tag = 103
        qqButton.addTarget(self, action: Selector("otherLoginButtonClick:"), forControlEvents: .TouchUpInside)
        qqButton.setImage(UIImage(named: "Share_QQIcon_70x70_"), forState: .Normal)
        view.addSubview(qqButton)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
