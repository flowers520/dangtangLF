//
//  LFTopicViewController.swift
//  dangtangLF
//
//  Created by jim on 17/1/31.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFTopicViewController: UITableViewController,LFHomeCellDelegate {

    var type = Int()
    //首页列表数据
    var items = [LFHomeItem]()
    //刷新控件
    var refreshControls = LFRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //界面设置
        setupUI()
    }
    
    //获取首页数据
    func loadHomeData(){
        LFNetworkTool.shareNetworkTool.loadHomeInfo(type) { [weak self](homeItems) -> () in
            self?.items = homeItems
            self?.tableView.reloadData()
            self?.refreshControls.endRefreshing()
            
        }
    }

    //界面设置
    func setupUI(){
        self.view.backgroundColor = LFGlobalColor()
        
        //tableView
        tableView.rowHeight = 160
        tableView.separatorStyle = .None
        tableView.contentInset = UIEdgeInsetsMake(kTitlesViewY + kTitlesViewH, 0, tabBarController!.tabBar.height, 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        tableView.registerClass(LFHomeCell.classForCoder(), forCellReuseIdentifier: "homeCellID")
        
        //添加刷新控件
        refreshControl = refreshControls
        refreshControl?.tintColor = UIColor.clearColor()
        refreshControl!.beginRefreshing()
        refreshControl!.addTarget(self, action: Selector("loadHomeData"), forControlEvents: .ValueChanged)
        
        
        //获取首页数据
        LFNetworkTool.shareNetworkTool.loadHomeInfo(type) { [weak self](homeItems) -> () in
            self!.items = homeItems
            self!.tableView.reloadData()
            self!.refreshControls.endRefreshing()
        }
    }
    
    

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  items.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("homeCellID", forIndexPath: indexPath) as! LFHomeCell
        cell.selectionStyle = .None
        cell.homeItem = items[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = LFDetailViewController()
        detailVC.homeItem = items[indexPath.row]
        detailVC.title = "攻略详情"
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //MARK: - LFHomeCellDelegate
    func homeCellDidClickedFavoriteButton(button: UIButton) {
        if !NSUserDefaults.standardUserDefaults().boolForKey(isLogin){
            let loginVC = LFLoginViewController()
            loginVC.title = "登录"
            let nav = LFNavigationController(rootViewController: loginVC)
            presentViewController(nav, animated: true, completion: nil)
        }else{
            
        }
    }



}
