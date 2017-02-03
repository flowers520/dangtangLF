//
//  LFSortTableView.swift
//  dangtangLF
//
//  Created by jim on 17/1/31.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit
import SnapKit

protocol LFSortTableViewDelegate: NSObjectProtocol{
    func sortView(sortView: LFSortTableView, didSelectSortAtIndexPath sort: String)
}

class LFSortTableView: UIView {

    weak var delegate: LFSortTableViewDelegate?
    let cells = ["默认排序","按热度排序","价格从低到高","价格从高到低"]
    //排序方式
    let sorts = ["","hot","price%3Aasc","price%3Adesc"]
    private lazy var bgView: UIImageView = {
        let bgView = UIImageView()
        bgView.userInteractionEnabled = true
        bgView.image = UIImage(named: "bg_menu_sort_140x46_")
        return bgView
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clearColor()
        tableView.rowHeight = 35
        tableView.scrollEnabled = false
        tableView.separatorStyle = .None
        tableView.registerClass(LFSortCell.classForCoder(), forCellReuseIdentifier: "sortTableViewCellID")
        return tableView
    }()
    
    func show(){
        let window = UIApplication.sharedApplication().keyWindow
        self.frame = UIScreen.mainScreen().bounds
        self.backgroundColor = UIColor.clearColor()
        window?.addSubview(self)
    }
    
    override func touchesEstimatedPropertiesUpdated(touches: Set<NSObject>) {
        self.removeFromSuperview()
    }
    
    func dismiss(){
        self.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupUI()
    }
    
    //界面设置
    func setupUI(){
        bgView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(60)
            make.right.equalTo(self)
            make.size.equalTo(CGSizeMake(140, 150))
        }
        addSubview(bgView)
        
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(bgView).offset(UIEdgeInsetsMake(kMargin, kMargin, -kMargin, 0))
        }
        bgView.addSubview(tableView)
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LFSortTableView: UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sortTableViewCellID", forIndexPath: indexPath) as! LFSortCell
        cell.titleLabel.text = cells[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sort = sorts[indexPath.row]
        delegate?.sortView(self, didSelectSortAtIndexPath: sort)
    }
}