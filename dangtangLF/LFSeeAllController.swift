

import UIKit


class LFSeeAllController: LFBaseViewController {

    var tableView: UITableView!
    var collections = [LFCollection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //分类界面 顶部 专题合集
        LFNetworkTool.shareNetworkTool.loadCategoryCollection(20) { (collections) -> () in
            self.collections = collections
            self.tableView.reloadData()
        }
        
        tableView = UITableView(frame: self.view.frame)
        tableView.registerClass(LFSeeAllTopicCell.classForCoder(), forCellReuseIdentifier: "seeAllCellID")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .None
        tableView.rowHeight = 160
        view.addSubview(tableView)
 
    }

}

extension LFSeeAllController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count ?? 0

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("seeAllCellID", forIndexPath: indexPath) as! LFSeeAllTopicCell
        cell.collection = collections[indexPath.row]
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let collectionDetailVC = LFCollectionDetailController()
        let collection = collections[indexPath.row]
        collectionDetailVC.title = collection.title
        collectionDetailVC.id = collection.id
        collectionDetailVC.type = "专题合集"
        navigationController?.pushViewController(collectionDetailVC, animated: true)
    }
}