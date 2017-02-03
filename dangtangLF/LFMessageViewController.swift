//
//  LFMessageViewController.swift
//  dangtangLF
//
//  Created by jim on 17/2/3.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

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
        tableView.registerClass(UITableView.self, forCellReuseIdentifier: "messageCellID")
        view.addSubview(tableView)
    }
    
}

extension LFMessageViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCellID", forIndexPath: indexPath)
        cell.textLabel?.text = "消息>>>>" + String(indexPath.row)
        return cell
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}