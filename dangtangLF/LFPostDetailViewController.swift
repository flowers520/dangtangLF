//
//  LFPostDetailViewController.swift
//  dangtangLF
//
//  Created by jim on 17/1/18.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFPostDetailViewController: LFBaseViewController {

    var webView: UIWebView!
    
    var post: LFCollectionPost?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView = UIWebView(frame: CGRectMake(0,0,SCREENW,SCREENH))
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .All
        webView.delegate = self
        let url = NSURL(string: (post?.content_url)!)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        self.view.addSubview(webView!)
        
    }


}
extension LFPostDetailViewController:UIWebViewDelegate{
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        print(webView.stringByEvaluatingJavaScriptFromString("document.documentElemet.innerHTML"))
    }
}
