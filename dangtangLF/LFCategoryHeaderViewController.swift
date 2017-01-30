//
//  LFCategoryHeaderViewController.swift
//  dangtangLF
//
//  Created by jim on 17/1/18.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFCategoryHeaderViewController: LFBaseViewController {

    var collections = [LFCollection]()
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //设置UI
        setupUI()
        
        //分类界面 顶部 专题合集
        LFNetworkTool.shareNetworkTool.loadCategoryCollection(6) { (collections) -> () in
            self.collections = collections
            self.collectionView?.reloadData()
        }
        
    }

    /**
    *  设置UI
    */
    private func setupUI(){
//        let headerView = NSBundle.mainBundle().loadNibNamed(String(LFTopHeaderView), owner: nil, options: nil).last as! LFTopHeaderView
        let headerView = LFTopHeaderView()
        headerView.frame = CGRectMake(0,0,SCREENW,40)
        headerView.backgroundColor = UIColor.whiteColor()
        headerView.delegate = self
        view.addSubview(headerView)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal
        let collectionView = UICollectionView(frame: CGRectMake(0, 40, SCREENW, 95), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(LFCategoryCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "categoryCollectionCellID")
        view.addSubview(collectionView)
        self.collectionView = collectionView
        
        
    }
    
}

extension LFCategoryHeaderViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,LFTopHeaderViewDelegate{
    
    //MARK: - LFTopHeaderViewDelegate
    func topViewDidClickedMoreButton(button: UIButton) {
        let seeAllVC = LFSeeAllController()
        seeAllVC.title = "查看全部"
        navigationController?.pushViewController(seeAllVC, animated: true)
    }
    
    //MARK: - UICollertionViewDataSouce
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("categoryCollectionCellID", forIndexPath: indexPath) as! LFCategoryCollectionViewCell
        cell.collection = collections[indexPath.item]
        return cell
    }
    //MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let collectionDetailVC = LFCollectionDetailController()
        let collection = collections[indexPath.item]
        collectionDetailVC.title = collection.title
        collectionDetailVC.id = collection.id
        collectionDetailVC.type = "专题合集"
        navigationController?.pushViewController(collectionDetailVC, animated: true)
    }
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(kitemW, kitemH)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin)
    }
}
