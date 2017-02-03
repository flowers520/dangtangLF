//
//  LFSearchViewController.swift
//  dangtangLF
//
//  Created by jim on 17/1/30.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFSearchViewController: LFBaseViewController {
    //搜索结果列表
    var  results = [LFSearchResult]()
    weak var collectionView: UICollectionView?
    
    
    private lazy var popView: LFSortTableView = {
        let popView = LFSortTableView()
        popView.delegate = self
        return popView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "搜索商品，专题"
        return searchBar
    }()
    private lazy var searchRecordView: LFSearchRecordView = {
        let searchRecordView = LFSearchRecordView()
        searchRecordView.backgroundColor = LFGlobalColor()
        searchRecordView.frame = CGRectMake(0,64,SCREENW,SCREENH-64)
        return searchRecordView
    }()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        searchBar.resignFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置导航栏
        setupNav()
        
        view.addSubview(searchRecordView)
    }

    //设置导航栏
    func setupNav(){
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: Selector("navigationBackClick"))
    }
    //设置collectionView
    private func setupCollectionView(){
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        collectionView.backgroundColor = view.backgroundColor
        collectionView.dataSource = self
        collectionView.registerClass(LFCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "searchCollectionCellID")
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    //搜索条件点击
    func sortButtonClick(){
        popView.show()
    }
    
    //返回按钮、取消按钮点击
    func navigationBackClick(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension LFSearchViewController: UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,LFCollectionViewCellDelegate,LFSortTableViewDelegate{
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        //设置collectionView
        setupCollectionView()
        return true
    }
    //搜索按钮点击
    func searchBarResultsListButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "checkUserType_backward_9x15_"), style: .Plain, target: self, action: Selector("navigationBackClick"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_sort_21x21_"), style: .Plain, target: self, action: Selector("sortButtonClick"))
        
        //根据搜索添加进行搜索
        let keyword = searchBar.text
        LFNetworkTool.shareNetworkTool.loadSearchResult(keyword!, sort: "") { [weak self] (results) -> () in
            self?.results = results
            self!.collectionView!.reloadData()
        }
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("searchCollectionCellID", forIndexPath: indexPath) as! LFCollectionViewCell
        cell.result = results[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    //MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let productDetailVC = LFProductDetailViewController()
        productDetailVC.title = "商品详情"
        productDetailVC.type = String(self)
        productDetailVC.result = results[indexPath.item]
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.mainScreen().bounds.width - 20) / 2
        let height: CGFloat = 245
        return CGSizeMake(width, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    // MARK: - YMCollectionViewCellDelegate
    func collectionViewCellDidClickedLikeButton(button: UIButton) {
        if !NSUserDefaults.standardUserDefaults().boolForKey(isLogin) {
            let loginVC = LFLoginViewController()
            loginVC.title = "登录"
            let nav = LFNavigationController(rootViewController: loginVC)
            presentViewController(nav, animated: true, completion: nil)
        } else {
            
        }
    }
    
    // MARK: - YMSortTableViewDelegate
    func sortView(sortView: LFSortTableView, didSelectSortAtIndexPath sort: String) {
        /// 根据搜索条件进行搜索
        let keyword = searchBar.text
        LFNetworkTool.shareNetworkTool.loadSearchResult(keyword!, sort: sort) { [weak self] (results) in
            sortView.dismiss()
            self!.results = results
            self!.collectionView!.reloadData()
        }
    }

}
