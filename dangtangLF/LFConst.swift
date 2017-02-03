//
//  LFConst.swift
//  dangtangLF
//
//  Created by jim on 17/1/13.
//  Copyright © 2017年 jim. All rights reserved.
//

import Foundation
import UIKit

//标题选项
enum LFTopicType:Int{
    //精选
    case Selection = 4
    //美食
    case Food = 14
    //家居
    case HouseHold = 16
    //数码
    case Digital = 17
    //美物
    case GoodThing = 13
    //杂货
    case Grocery = 22
}

//分享按钮
enum LFShareButtonType: Int{
    //微信朋友圈
    case WeChatTimeline = 0
    //微信好友
    case weChatSession = 1
    //微博
    case weibo = 2
    //QQ 空间
    case QZone = 3
    //QQ 好友
    case QQFriends = 4
    //复制链接
    case CopyLink = 5
}

//其他登录方式
enum LFOtherLoginButtonType: Int{
    //微博
    case weiboLogin = 101
    //微信
    case wechatLogin = 102
    //QQ 
    case QQLogin = 103
}

//服务器地址
let BASE_URL = "http://api.dantangapp.com/"
//第一次启动
let LFFirstLaunch = "firstLaunch"
//是否登录
let isLogin = "isLogin"
//code 码 200 操作成功
let RETURN_OK = 200
//间距
let kMargin: CGFloat = 10.0
//圆角
let kCornerRadius: CGFloat = 5.0
//线宽
let KlineWidth: CGFloat = 1.0
//首页顶部标签指示条的高度
let kIndicatorViewH: CGFloat = 2.0
//新特性界面图片数量
let kNewFeatureCount = 4
//顶部标题的高度
let kTitlesViewH: CGFloat = 35
//顶部标题的y
let kTitlesViewY: CGFloat = 64
//动画时长
let kAnimationDuration = 0.25
//屏幕的宽度
let SCREENW = UIScreen.mainScreen().bounds.size.width
//屏幕的高度
let SCREENH = UIScreen.mainScreen().bounds.size.height
//分类界面 顶部 item的高度
let kitemH: CGFloat = 75
//分类界面 顶部 item的宽度
let kitemW: CGFloat = 150
//ME界面头部图像的高度
let kLFMineHeaderImageHeight: CGFloat = 200
//分享按钮背景高度
let kTopViewH: CGFloat = 230


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

//iPhone 5
let isIPhone5 = SCREENH == 568 ? true : false
//iPhone 6 
let isIPhone6 = SCREENH == 667 ? true : false
//iPhone 6P
let isIPhone6P = SCREENH == 736 ? true : false