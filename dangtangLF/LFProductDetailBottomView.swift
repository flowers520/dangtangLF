

import UIKit
import SnapKit

class LFProductDetailBottomView: UIView {

    var comments = [LFComment]()
    var choiceButtonView =  LFDetailChoiceButtonView()
    
    var webView = UIWebView()
    var tableView = UITableView()
    
    var product: LFProduct?{
        didSet{
            weak var weakSelf = self
            //获取单品详细数据
            LFNetworkTool.shareNetworkTool.loadProductDetailData(product!.id!) { (productDetail) -> () in
                weakSelf?.choiceButtonView.commentButton.setTitle("评论\(productDetail.comments_count!)", forState: .Normal)
                weakSelf?.webView.loadHTMLString(productDetail.detail_html!, baseURL: nil)
            }
           //获取评论数据
            LFNetworkTool.shareNetworkTool.loadProductDetailComments(product!.id!) { (comments) -> () in
                weakSelf?.comments = comments
                weakSelf?.tableView.reloadData()
            }
        }
    }
    
    var result: LFSearchResult?{
        didSet{
            weak var weakSelf = self
            //获取单品详细数据
            LFNetworkTool.shareNetworkTool.loadProductDetailData(result!.id!) { (productDetail) -> () in
                weakSelf?.choiceButtonView.commentButton.setTitle("评论\(productDetail.comments_count!)", forState: .Normal)
                weakSelf?.webView.loadHTMLString(productDetail.detail_html!, baseURL: nil)
            }
            //获取评论数据
            LFNetworkTool.shareNetworkTool.loadProductDetailComments(result!.id!) { (comments) -> () in
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
    private func setupUI(){
        
        choiceButtonView.delegate = self
        addSubview(choiceButtonView)
        
        tableView.hidden = true
        tableView.registerClass(LFCommentCell.classForCoder(), forCellReuseIdentifier: "commentCell")
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.rowHeight = 64
        addSubview(tableView)
        
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .All
        webView.delegate = self
        addSubview(webView)
        
        choiceButtonView.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(SCREENW, 44))
            make.top.equalTo(self)
        }

        tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(choiceButtonView.snp_bottom)
            make.left.right.bottom.equalTo(self)
        }

        webView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(choiceButtonView.snp_bottom)
            make.left.right.bottom.equalTo(self)
        }

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
    func choiceCommentButtonClick() {
        tableView.hidden = false
        webView.hidden = true
    }
    
    //MARK: - UIWebViewDelegate
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
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
