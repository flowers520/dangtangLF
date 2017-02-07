//
//  LFRefreshControl.swift
//  dangtangLF
//
//  Created by jim on 17/1/30.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit
import SnapKit

class LFRefreshControl: UIRefreshControl {

    //定义变量记录是否需要旋转监听
    private var rotationArrowFlag = false
    //定义变量记录当前是否正在执行圈圈动画
    private var loadingViewAnimationFlag = false
    //懒加载
    private lazy var refreshView:LFRefreshView! = LFRefreshView()
    //定义时钟
    var timer:NSTimer!
    
    override init() {
        super.init()
        setupUI()
    }
    
    //设置界面
    private func setupUI(){
        //添加刷新控件
        addSubview(refreshView)
        
        refreshView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self)
            make.size.equalTo(CGSizeMake(170, 60))
        }
        /**
        1.当用户下拉到一定程度的时候需要旋转箭头
        2.当用户上推到一定程度的时需要旋转箭头
        3.当下拉刷新控件触发刷新方法的时候，需要显示刷新界面（转轮）
        
        通过观察：
        越往下拉：值就越小
        越往上推：值就越大
        
        */
        addObserver(self, forKeyPath: "frame", options: .New, context: nil)
    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        //过滤不需要的数据
        if frame.origin.y >= 0{
            return
        }
        //判断是否已经触发刷新事件 和 圈圈动画
        if refreshing && !loadingViewAnimationFlag{
            //执行动画
            loadingViewAnimationFlag = true
            
            refreshView.startLoadingViewAnimation()
//            animateLabelRefreshStep1()
            return
        }
        if frame.origin.y >= -40 && rotationArrowFlag{ //不旋转箭头
            //旋转回到原始位置
            rotationArrowFlag = false
            refreshView.rotationArrowIcon(rotationArrowFlag)
        }else if frame.origin.y < -40 && !rotationArrowFlag {//旋转箭头
            rotationArrowFlag = true
            refreshView.rotationArrowIcon(rotationArrowFlag)
        }
    }
    
    //结束刷新
    override func endRefreshing() {
        super.endRefreshing()
        //关闭圈圈动画
        refreshView.stopLoadingViewAnimation()
        loadingViewAnimationFlag = false
    }
    

    //label animation step1
    func animateLabelRefreshStep1(){
        refreshView.isAnimatingLabel = true
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            self.refreshView.labels[self.refreshView.currentLabelIndex].transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
            self.refreshView.labels[self.refreshView.currentLabelIndex].textColor = self.getNextColor()
            }) { (finished) -> Void in
                UIView.animateWithDuration(0.05, delay: 0, options: .CurveLinear, animations: { () -> Void in
                    self.refreshView.labels[self.refreshView.currentLabelIndex].transform = CGAffineTransformIdentity
                    self.refreshView.labels[self.refreshView.currentLabelIndex].textColor = UIColor.blackColor()
                    }, completion: { (finished) -> Void in
                        ++self.refreshView.currentLabelIndex
                        if self.refreshView.currentLabelIndex < self.refreshView.labels.count{
                            self.animateLabelRefreshStep1()
                        }else{
                            self.animatieLabelRefreshStep2()
   
                        }
                })
        }
    }
    //label animation step2
    func animatieLabelRefreshStep2(){
        UIView.animateWithDuration(0.35, delay: 0, options: .CurveLinear, animations: { () -> Void in
            for index in 0..<self.refreshView.labels.count{
                self.refreshView.labels[index].transform = CGAffineTransformMakeScale(1.5, 1.5)
            }
            
            }) { (finished) -> Void in
                UIView.animateWithDuration(0.25, delay: 0, options: .CurveLinear, animations: { () -> Void in
                    for index in 0..<self.refreshView.labels.count{
                        self.refreshView.labels[index].transform = CGAffineTransformIdentity
                    }
                    }, completion: { (finished) -> Void in
                        if self.refreshing{
                            self.refreshView.currentLabelIndex = 0
                            self.animateLabelRefreshStep1()
                        }else{
                            self.refreshView.isAnimatingLabel = false
                            self.refreshView.currentLabelIndex = 0
                            for index in 0..<self.refreshView.labels.count{
                                self.refreshView.labels[index].textColor = UIColor.blackColor()
                                self.refreshView.labels[index].transform = CGAffineTransformIdentity
                            }
                        }
                })
                
        }
    }
    
    //随机颜色
    func getNextColor() -> UIColor{
        var colorsArray: Array<UIColor> = [UIColor.magentaColor(),UIColor.brownColor(),UIColor.yellowColor(),UIColor.redColor(),UIColor.greenColor(),UIColor.blueColor(),UIColor.orangeColor()]
        if refreshView.currentColorIndex == colorsArray.count{
            refreshView.currentColorIndex = 0
        }
        let returnColor = colorsArray[refreshView.currentColorIndex]
        ++refreshView.currentColorIndex
        return returnColor
    }

    
    //时钟四秒停留
    func timerDelay4(){
        
        timer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: Selector("endOfWork"), userInfo: nil, repeats: true)
    }
    func endOfWord(){
        endRefreshing()
        //关闭时钟
        timer.invalidate()
        timer = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
