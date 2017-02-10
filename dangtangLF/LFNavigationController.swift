

import UIKit
import SVProgressHUD

class LFNavigationController: UINavigationController{

    internal override class func initialize(){
        super.initialize()
        //设置导航栏标题
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor =  LFGlobalRedColor()
        navBar.tintColor = UIColor.whiteColor()
        navBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName:UIFont.systemFontOfSize(20)]
    }

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        //这时push进来的控制器viewController，不是第一个自控制器（不是跟控制器）
        if viewControllers.count > 0{
            //push后隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "checkUserType_backward_9x15_"), style: .Plain, target: self, action: Selector("navigationBackClick"))
        }
        super.pushViewController(viewController, animated: true)
    }

    //返回按钮
    func navigationBackClick(){
        if SVProgressHUD.isVisible(){
            SVProgressHUD.dismiss()
        }
        if UIApplication.sharedApplication().networkActivityIndicatorVisible{
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        popViewControllerAnimated(true)
    }
    
}
