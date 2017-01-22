//
//  LFCollectionDetailController.swift
//  dangtangLF
//
//  Created by jim on 17/1/18.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

let collectionTableCellID = "LFCollectionTableViewCell"

class LFCollectionDetailController: UIViewController {

    var type = String()
    var posts = [LFCollectionPost]()
    var id: Int?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib = UINib(nibName: String(LFCollectionTableViewCell), bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: collectionTableCellID)
        tableView.rowHeight = 150
        tableView.separatorStyle = .None
        if type == "专题合集"{
            LFNetworkTool.shareNetworkTool.loadCollectionPosts(id!, finished: { [weak self](posts) -> () in
                self?.posts = posts
                self?.tableView.reloadData()
            })
        }else if type == "风格品类"{
            LFNetworkTool.shareNetworkTool.loadStylesOrCategoryInfo(id!, finished: { (item) -> () in
                self.posts = item
                self.tableView.reloadData()
            })
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LFCollectionDetailController:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //？？ 对posts.count进行判断，如果不为nil则解包，否则就返回0
        return posts.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(collectionTableCellID) as! LFCollectionTableViewCell
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
