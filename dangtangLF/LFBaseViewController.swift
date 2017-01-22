//
//  LFBaseViewController.swift
//  dangtangLF
//
//  Created by jim on 17/1/14.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit
import SVProgressHUD
import FDFullscreenPopGesture

class LFBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = LFGlobalRedColor()
        navigationController?.fd_prefersNavigationBarHidden = true
        SVProgressHUD.setDefaultMaskType(.Black)
        SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
        SVProgressHUD.setForegroundColor(UIColor.whiteColor())
       
    }


}
