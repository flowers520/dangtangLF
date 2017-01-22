//
//  LFConst.swift
//  dangtangLF
//
//  Created by jim on 17/1/13.
//  Copyright © 2017年 jim. All rights reserved.
//

import Foundation
import UIKit



//服务器地址
let BASE_URL = "http://api.dantangapp.com/"
//code 码 200 操作成功
let RETURN_OK = 200
//间距
let kMargin: CGFloat = 10.0
//圆角
let kCornerRadius: CGFloat = 5.0
//屏幕的宽度
let SCREENW = UIScreen.mainScreen().bounds.size.width
//屏幕的高度
let SCREENH = UIScreen.mainScreen().bounds.size.height

//分类界面 顶部 item的高度
let kitemH: CGFloat = 75
//分类界面 顶部 item的宽度
let kitemW: CGFloat = 150

//RGBA的颜色设置
func LFColor(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat)->UIColor{
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

//背景灰色
func LFGlobalColor()->UIColor{
    return LFColor(240, g: 240, b: 240, a: 1)
}

//红色
func LFGlobalRedColor()->UIColor{
    return LFColor(245, g: 80, b: 83, a: 1.0)
}