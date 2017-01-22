//
//  LFTabBarController.swift
//  dangtangLF
//
//  Created by jim on 17/1/13.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //添加自控制器
        addChildViewControllers()
    }

    private func addChildViewControllers(){
        addChildViewController("LFHomeViewController", title: "首页", imageName: "TabBar_home_23x23_")
        addChildViewController("LFProductViewController", title: "单品", imageName: "TabBar_gift_23x23_")
        addChildViewController("LFClassifyViewController", title: "分类", imageName: "TabBar_category_23x23_")
        addChildViewController("LFMeViewController", title: "我", imageName: "TabBar_me_boy_23x23_")
    }
    
    private func addChildViewController(childControllerName:String,title:String,imageName:String){
        //动态获取
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        //将字符串转化为类，默认情况下命名空间就是项目名称，但是命名空间可以修改
        let cls:AnyClass? = NSClassFromString(ns + "." + childControllerName)
        let vcClass = cls as! UIViewController.Type
        let vc = vcClass.init()
        //设置对应的数据
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName+"selected")
        vc.title = title
        //给每一个控制器包装一个导航器
        let nav = LFNavigationController()
        nav.addChildViewController(vc)
        addChildViewController(nav)
        
    }

}

extension UIImage{
    static func settingRenderingMode(imageName:String)->UIImage{
        return UIImage(named: imageName)!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
    }
}
