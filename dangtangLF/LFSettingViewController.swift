//
//  LFSettingViewController.swift
//  dangtangLF
//
//  Created by jim on 17/2/3.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFSettingViewController: LFBaseViewController {

    var settings = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //从plist文件上加载数据
        configCellFromPlist()
        //设置tableView
        setupTableView()
    }

    //从plistt文件上加载数据
    func configCellFromPlist(){
        let path = NSBundle.mainBundle().pathForResource("SettingCell", ofType: ".plist")
        let settingsPlist = NSArray.init(contentsOfFile: path!)
        for arrayDict in settingsPlist!{
            let array = arrayDict as! NSArray
            var sections = [AnyObject]()
            for dict in array {
                let setting = LFSetting(dict: dict as! [String: AnyObject])
                sections.append(setting)
            }
            settings.append(sections)
        }

    }
    
    //创建 tableView 
    private func setupTableView(){
        let tableView = UITableView()
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.registerClass(LFSettingCell.classForCoder(), forCellReuseIdentifier: "messageCellID")
        tableView.tableFooterView = UIView()
    }
    
}

extension LFSettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return settings.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let setting = settings[section] as! [LFSetting]
        return setting.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCellID", forIndexPath: indexPath) as! LFSettingCell
        let setting = settings[indexPath.section] as! [LFSetting]
        cell.setting = setting[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kMargin + 5
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

