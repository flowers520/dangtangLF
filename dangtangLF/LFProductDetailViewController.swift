//
//  LFProductDetailViewController.swift
//  dangtangLF
//
//  Created by jim on 17/2/1.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit
import SnapKit

class LFProductDetailViewController: LFBaseViewController{

    var product: LFProduct?
    var result: LFSearchResult?
    var type = String()
    
    //scrollView
    var scrollView: LFDetailScrollView! = LFDetailScrollView()
    //底部栏
    var toolBarView =  LFProductDetailToolBar()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //界面设置
        setupUI()
        
    }

    //分享按钮点击
    func shareBBItemClick(){
        LFActionSheet.show()
    }
    

    //MARK: - 设置导航栏和底部栏
    private func setupUI(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "GiftShare_icon_18x22_"), style: .Plain, target: self, action: Selector("shareBBItemClick"))
        
        scrollView.contentSize = CGSizeMake(SCREENW, SCREENH - 64 - 45 + kMargin + 520)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        view.addSubview(scrollView)

        toolBarView.delegate = self
        view.addSubview(toolBarView)
        
        scrollView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(toolBarView.snp_top)
        }
        
        toolBarView.snp_makeConstraints { (make) -> Void in
            make.left.bottom.right.equalTo(view)
            make.height.equalTo(45)
        }

    }

}

extension LFProductDetailViewController: UIScrollViewDelegate, LFProductDetailToolBarDelegate{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var offsetY = scrollView.contentOffset.y
        if offsetY >= 465{
            offsetY = CGFloat(465)
            scrollView.contentOffset = CGPointMake(0, offsetY)
        }
    }
    
    //底部栏按钮点击
    func toolBarDidClickedTMALLButton() {
        let tmallVC = LFTMALLViewController()
        tmallVC.title = "商品详情"
        tmallVC.product = product
        let nav = LFNavigationController(rootViewController: tmallVC)
        presentViewController(nav, animated: true, completion: nil)
    }
}
