//
//  LFCollectionDetailController.swift
//  dangtangLF
//
//  Created by jim on 17/1/18.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit


class LFCollectionDetailController: UIViewController {

    var type = String()
    var posts = [LFCollectionPost]()
    var id: Int?
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //界面设置
        setupUI()
    }
    
    func setupUI(){
        
        tableView = UITableView(frame: self.view.frame)
        tableView.registerClass(LFCollectionTableViewCell.classForCoder(), forCellReuseIdentifier: "collectionTableCellID")
        tableView.rowHeight = 150
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .None
        self.view.addSubview(tableView)
        if type == "专题合集"{
            LFNetworkTool.shareNetworkTool.loadCollectionPosts(id!, finished: { [weak self](posts) -> () in
                self?.posts = posts
                self?.tableView.reloadData()
                })
        }else if type == "风格品类"{
            LFNetworkTool.shareNetworkTool.loadStylesOrCategoryInfo(id!, finished: { [weak self](items) -> () in
                self!.posts = items
                self!.tableView.reloadData()
                })
        }

    }


}

extension LFCollectionDetailController:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //？？ 对posts.count进行判断，如果不为nil则解包，否则就返回0
        return posts.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("collectionTableCellID", forIndexPath: indexPath) as! LFCollectionTableViewCell
        cell.selectionStyle = .None
        cell.collectionPost = posts[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let postDetailVC = LFPostDetailViewController()
        postDetailVC.post = posts[indexPath.row]
        postDetailVC.title = "攻略详情"
        navigationController?.pushViewController(postDetailVC, animated: true)
    }
}
