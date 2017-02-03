//
//  LFProductDetailBottomView.swift
//  dangtangLF
//
//  Created by jim on 17/2/1.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit
import SnapKit

class LFProductDetailBottomView: UIView {

    var comments = [LFComment]()
    var webView: UIWebView!
    var choiceButtonView: LFDetailChoiceButtonView!
    var tableView: UITableView!
    var product: LFProduct?{
        didSet{
            weak var weakSelf = self
            //获取单品详细数据
            LFNetworkTool.shareNetworkTool.loadProductDetailData(product!.id!) { (productDetail) -> () in
                weakSelf?.choiceButtonView.commentButton.setTitle("评论\(productDetail.comments_count!)", forState: .Normal)
                weakSelf?.webView.loadHTMLString(productDetail.detail_html!, baseURL: nil)
            }
           //获取评论数据
            LFNetworkTool.shareNetworkTool.loadProductDetailComments((product?.id)!) { (comments) -> () in
                weakSelf?.comments = comments
                weakSelf?.tableView.reloadData()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //界面设置
        setupUI()
    }
    
    //MARK: - 界面设置
    func setupUI(){
        choiceButtonView.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(SCREENW, 44))
            make.top.equalTo(self)
        }
        choiceButtonView.delegate = self
        addSubview(choiceButtonView)
        
        tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(choiceButtonView.snp_bottom)
            make.left.right.bottom.equalTo(self)
        }
        tableView.hidden = true
        tableView.registerClass(LFCommentCell.classForCoder(), forCellReuseIdentifier: "commentCell")
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.rowHeight = 64
        addSubview(tableView)
        
        webView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(choiceButtonView.snp_bottom)
            make.left.right.bottom.equalTo(self)
        }
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .All
        webView.delegate = self
        addSubview(webView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LFProductDetailBottomView: LFDetailChoiceButtonViewDelegate, UIWebViewDelegate, UITableViewDataSource{
    //MARK: - LFDetailChoiceButtonViewDelegate 图文介绍
    func choiceIntroduceButtonClick() {
        tableView.hidden = true
        webView.hidden = false
    }
    func choichCommentButtonClick() {
        tableView.hidden = false
        webView.hidden = true
    }
    
    //MARK: - UIWebViewDelegate
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! LFCommentCell
        cell.comment = comments[indexPath.row]
        return cell
    }
}
