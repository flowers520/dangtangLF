

import UIKit

class LFMeViewController: UIViewController {

    let cellCount = 0
    
    private lazy var headerView: LFMineHeaderView = {
        let headerView = LFMineHeaderView()
        headerView.frame = CGRectMake(0, 0, SCREENW, kLFMineHeaderImageHeight)
        headerView.iconButton.addTarget(self, action: Selector("iconButtonClick"), forControlEvents: .TouchUpInside)
        headerView.messageButton.addTarget(self, action: Selector("messageButtonClick"), forControlEvents: .TouchUpInside)
        headerView.settingButton.addTarget(self, action: Selector("settingButtonClick"), forControlEvents: .TouchUpInside)
        return headerView
    }()
    
    private lazy var footerView: LFMeFooterView = {
        let footerView = LFMeFooterView()
        footerView.width = SCREENW
        footerView.height = 200
        return footerView
    }()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: - 头部按钮点击
    func iconButtonClick() {
        // 判断是否登录
        if NSUserDefaults.standardUserDefaults().boolForKey(isLogin) {
            let actionSheet = UIAlertController(title: "", message: nil, preferredStyle: .ActionSheet)
            let cameraAction = UIAlertAction(title: "编辑资料", style: .Default, handler: { (_) in
                
            })
            let photoAction = UIAlertAction(title: "退出登录", style: .Destructive, handler: { (_) in
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: isLogin)
            })
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            actionSheet.addAction(cancelAction)
            actionSheet.addAction(cameraAction)
            actionSheet.addAction(photoAction)
            self.presentViewController(actionSheet, animated: true, completion: nil)
        } else {
            let loginVC = LFLoginViewController()
            loginVC.title = "登录"
            let nav = LFNavigationController(rootViewController: loginVC)
            presentViewController(nav, animated: true, completion: nil)
        }
    }
    
    func messageButtonClick() {
        let messageVC = LFMessageViewController()
        messageVC.title = "消息"
        navigationController?.pushViewController(messageVC, animated: true)
    }
    
    func settingButtonClick() {
        let settingVC = LFSettingViewController()
        settingVC.title = "更多"
        navigationController?.pushViewController(settingVC, animated: true)
    }

    
    //MARK: - 创建 tableView
    private func setupTableView(){
        let tableView = UITableView()
        tableView.frame = view.bounds
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        view.addSubview(tableView)
    }
    
}

extension LFMeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let choiceView = LFMeChoiceView()
        return choiceView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            var tempFrame = headerView.bgImageView.frame
            tempFrame.origin.y = offsetY
            tempFrame.size.height = kLFMineHeaderImageHeight - offsetY
            headerView.bgImageView.frame = tempFrame
        }
        
    }
}
