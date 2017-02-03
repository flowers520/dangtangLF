//
//  LFRefreshView.swift
//  dangtangLF
//
//  Created by jim on 17/1/30.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFRefreshView: UIRefreshControl {

    var tipView: UIView!
    var arrowIcon: UIImageView!
    var downRefreshingL: UILabel!
    var isRefreshingL: UILabel!
    var loadingView: UIImageView!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    //设置界面
    func setupUI(){
        self.frame = CGRectMake(0, 0, 170, 60)
        
        loadingView.frame = CGRectMake(16, 14, 32, 32)
        loadingView.image = UIImage(named: "tableview_loading")
        addSubview(loadingView)
        
        isRefreshingL = UILabel(frame: CGRectMake(53,20,117,20))
        isRefreshingL.text = "正在刷新..."
        isRefreshingL.textColor = UIColor.blackColor()
        isRefreshingL.font = UIFont.systemFontOfSize(16)
        addSubview(isRefreshingL)
        
        tipView.frame = CGRectMake(0, 0, 170, 60)
        addSubview(tipView)
        
        arrowIcon.frame = CGRectMake(10, 14, 32, 32)
        arrowIcon.image = UIImage(named: "tableview_pull_refresh")
        addSubview(arrowIcon)
        
        downRefreshingL.frame = CGRectMake(47, 20, 123, 20)
        downRefreshingL.text = "下拉刷新..."
        downRefreshingL.textColor = UIColor.blackColor()
        downRefreshingL.font = UIFont.systemFontOfSize(16)
        downRefreshingL.textAlignment = .Left
        addSubview(downRefreshingL)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //旋转箭头
    func rotationArrowIcon(flag: Bool){
        var angle = M_PI
        angle += flag ? -0.01 : 0.01
        UIView.animateWithDuration(kAnimationDuration) { () -> Void in
            self.arrowIcon.transform = CGAffineTransformRotate(self.arrowIcon.transform, CGFloat(angle))
        }
    }
    
    //开始转圈动画
    func startLoadingViewAnimation(){
        tipView.hidden = true
        //创建动画
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * M_PI
        animation.duration = 1
        animation.repeatCount = MAXFLOAT
        animation.removedOnCompletion = false
        loadingView.layer.addAnimation(animation, forKey: nil)
    }
    //停止动画
    func stopLoadingViewAnimation(){
        tipView.hidden = false
        loadingView.layer.removeAllAnimations()
    }
    

}
