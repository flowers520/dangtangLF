

import UIKit
import SVProgressHUD

class LFDetailViewController: LFBaseViewController {

    var homeItem: LFHomeItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = UIWebView()
        webView.frame = view.bounds
        //自动对页面进行缩放以适应屏幕
        webView.scalesPageToFit = true
        let url = NSURL(string: (homeItem?.content_url)!)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        webView.delegate = self
        view.addSubview(webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension LFDetailViewController: UIWebViewDelegate{
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.setStatus("正在加载...")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
}
