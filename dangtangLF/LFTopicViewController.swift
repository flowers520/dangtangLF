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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //界面设置
        setupUI()
    }
    
    //获取首页数据
    func loadHomeData(){
        LFNetworkTool.shareNetworkTool.loadHomeInfo(type) { [weak self](homeItems) -> () in
            self?.items = homeItems
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
            
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
        refreshControl = LFRefreshControl()
        refreshControl?.beginRefreshing()
        refreshControl?.addTarget(self, action: Selector("loadHomeData"), forControlEvents: .TouchUpInside)
        
        //获取首页数据
        LFNetworkTool.shareNetworkTool.loadHomeInfo(type) { [weak self](homeItems) -> () in
            self!.items = homeItems
            self!.tableView.reloadData()
            self!.refreshControl?.endRefreshing()
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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
