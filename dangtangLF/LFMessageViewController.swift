
import UIKit
import SVProgressHUD

class LFMessageViewController: LFBaseViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }

    //创建tableView
    private func setupTableView(){
        let tableView = UITableView()
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "messageCellID")
        view.addSubview(tableView)
    }
    
    
}

extension LFMessageViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCellID", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = "消息>>>>" + String(indexPath.row + 1)
        return cell        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //按下高亮
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        SVProgressHUD.showInfoWithStatus("你点击是\(indexPath.row+1)行")
    }
}