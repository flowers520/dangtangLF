//
//  LFClassifyViewController.swift
//  dangtangLF
//
//  Created by jim on 17/1/13.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFClassifyViewController: LFBaseViewController, LFCategoryBottomViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Feed_SearchBtn_18x18_"), style: .Plain, target: self, action: Selector("categoryRightBBClick"))
        
        setupScrollView()
    }


    private func setupScrollView(){
        view.addSubview(scrollView)
        //顶部控制器
        let headerViewController = LFCategoryHeaderViewController()
        addChildViewController(headerViewController)
        
        let topBGView = UIView(frame: CGRectMake(0,0,SCREENW,135))
        scrollView.addSubview(topBGView)
        
        let headerVC = childViewControllers[0]
        topBGView.addSubview(headerVC.view)
        
        let bottomBGView = LFCategoryBottomView(frame: CGRectMake(0,CGRectGetMaxY(topBGView.frame)+10,SCREENW,SCREENH-160))
        bottomBGView.backgroundColor = LFGlobalColor()
        bottomBGView.delegate = self
        scrollView.addSubview(bottomBGView)
        scrollView.contentSize = CGSizeMake(SCREENW, CGRectGetMaxY(bottomBGView.frame))

    }
    
    func categoryRightBBClick(){
        let searchBarVC = LFSearchViewController()
        navigationController?.pushViewController(searchBarVC, animated: true)
    }

    /**
    *  懒加载创建 scrollView
    */
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.scrollEnabled = true
        scrollView.backgroundColor = LFGlobalColor()
        scrollView.frame = CGRectMake(0,0,SCREENW,SCREENH)
        return scrollView
        
    }()
    
    func bottomViewButtonDidClicked(button: UIButton) {
        print("bottomViewButtonDidClicked")
        let collectionDetailVC = LFCollectionDetailController()
        collectionDetailVC.title = button.titleLabel?.text
        collectionDetailVC.id = button.tag
        collectionDetailVC.type = "风格品类"
        navigationController?.pushViewController(collectionDetailVC, animated: true)
    }

}
