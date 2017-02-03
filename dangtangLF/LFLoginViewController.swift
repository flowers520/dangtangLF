//
//  LFLoginViewController.swift
//  dangtangLF
//
//  Created by jim on 17/2/1.
//  Copyright © 2017年 jim. All rights reserved.
//

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
                SVProgressHUD.showWithStatus("微博登录....")
                break
            case .wechatLogin:
                SVProgressHUD.showWithStatus("微信登录....")
                break
            case .QQLogin:
                SVProgressHUD.showWithStatus("QQ登录....")
                break
            default:
                break
            }
        }
    }
    
    //MARK: - 界面设置
    func setupUI(){
        self.view.frame = CGRectMake(0, 0, 600, 600)
        
        loginview.frame = CGRectMake(0, 100, 600, 86)
        view.addSubview(loginview)
        //登录项
        loginLineView.frame = CGRectMake(15, 42, 585, 1)
        loginLineView.backgroundColor = UIColor.grayColor()
        loginview.addSubview(loginLineView)
        
        mobileLabel.frame = CGRectMake(15, 0, 51, 43)
        mobileLabel.text = "手机号:"
        mobileLabel.textColor = UIColor.grayColor()
        mobileLabel.textAlignment = .Left
        mobileLabel.font = UIFont.systemFontOfSize(17)
        loginview.addSubview(mobileLabel)
        
        passwordLabel.frame = CGRectMake(15, 43, 34, 43)
        passwordLabel.text = "密码:"
        passwordLabel.textColor = UIColor.grayColor()
        passwordLabel.font = UIFont.systemFontOfSize(17)
        passwordLabel.textAlignment = .Left
        loginview.addSubview(passwordLabel)
        
        mobileField.frame = CGRectMake(76, 0, 524, 42)
        mobileField.placeholder = "请输入手机号码"
        mobileField.textAlignment = .Left
        mobileField.contentHorizontalAlignment = .Center
        mobileField.font = UIFont.systemFontOfSize(14)
        loginview.addSubview(mobileField)
     
        passwordField.frame = CGRectMake(76, 43, 524, 43)
        passwordField.placeholder = "请输入密码"
        passwordField.textAlignment = .Left
        passwordField.contentHorizontalAlignment = .Center
        passwordField.font = UIFont.systemFontOfSize(14)
        loginview.addSubview(passwordField)
        
        //登录按钮
        loginButton.frame = CGRectMake(15, 216, 570, 36)
        loginButton.setTitle("登录", forState: .Normal)
        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginButton.backgroundColor = UIColor.redColor()
        loginButton.titleLabel?.textAlignment = .Center
        loginButton.titleLabel?.font = UIFont.systemFontOfSize(17)
        view.addSubview(loginButton)
        
        //忘记密码
        forgetPwdBtn.frame = CGRectMake(529, 267, 56, 30)
        forgetPwdBtn.setTitle("忘记密码", forState: .Normal)
        forgetPwdBtn.setTitleColor(UIColor.grayColor(), forState: .Normal)
        forgetPwdBtn.titleLabel?.textAlignment = .Center
        forgetPwdBtn.backgroundColor = UIColor.clearColor()
        forgetPwdBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        view.addSubview(forgetPwdBtn)
        
        //社交
        socialView.frame = CGRectMake(0, 312, 600, 30)
        view.addSubview(socialView)
        
        socialLabel.frame = CGRectMake(244, 0, 112, 30)
        socialLabel.text = "使用社交账号登录"
        socialLabel.textColor = UIColor.grayColor()
        socialLabel.font = UIFont.systemFontOfSize(14)
        socialView.addSubview(socialLabel)
        
        socialLeftView.frame = CGRectMake(15, 14, 219, 1)
        socialLeftView.backgroundColor = UIColor.grayColor()
        socialView.addSubview(socialLeftView)
        
        socialRightView.frame = CGRectMake(366, 14, 219, 1)
        socialRightView.backgroundColor = UIColor.grayColor()
        socialView.addSubview(socialRightView)
        
        //微博
        weiboButton.frame = CGRectMake(165, 362, 70, 70)
        weiboButton.setImage(UIImage(named: "Share_WeiboIcon_70x70_"), forState: .Normal)
        weiboButton.tag = 101
        weiboButton.addTarget(self, action: Selector("otherLoginButtonClick:"), forControlEvents: .TouchUpInside)
        view.addSubview(weiboButton)
        //微信
        weChatButton.frame = CGRectMake(265, 362, 70, 70)
        weChatButton.tag = 102
        weChatButton.addTarget(self, action: Selector("otherLoginButtonClick:"), forControlEvents: .TouchUpInside)
        weChatButton.setImage(UIImage(named: "Share_WeChatSessionIcon_70x70_"), forState: .Normal)
        view.addSubview(weChatButton)
        //qq
        qqButton.frame = CGRectMake(365, 362, 70, 70)
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
