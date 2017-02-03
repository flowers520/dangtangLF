//
//  LFProductViewController.swift
//  dangtangLF
//
//  Created by jim on 17/1/13.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFProductViewController: UIViewController {

    var products = [LFProduct]()
    weak var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置collectionView
        setupCollectionView()
        
        LFNetworkTool.shareNetworkTool.loadProductData { [weak self](products) -> () in
            self?.products = products
            self?.collectionView?.reloadData()
        }
    }

    //设置collectionView
    private func setupCollectionView(){
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = view.backgroundColor
        collectionView.dataSource = self
        collectionView.registerClass(LFCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "collectionCellID")
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension LFProductViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, LFCollectionViewCellDelegate{
    //MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCellID", forIndexPath: indexPath) as! LFCollectionViewCell
        cell.product = products[indexPath.item]
        cell.delegate = self
        return cell
    }
    //MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let productDetailVC = LFProductDetailViewController()
        productDetailVC.title = "商品详情"
        productDetailVC.product = products[indexPath.item]
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.mainScreen().bounds.width - 20) / 2
        let height: CGFloat = 245
        return CGSizeMake(width, height)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    //MARK: - LFCollectionViewCellDelegate
    func collectionViewCellDidClickedLikeButton(button: UIButton){
        if !NSUserDefaults.standardUserDefaults().boolForKey(isLogin){
            let loginVC = LFLoginViewController()
            loginVC.title = "登录"
            let nav = LFNavigationController(rootViewController: loginVC)
            presentViewController(nav, animated: true, completion: nil)
        }else{
            
        }
    }
}

